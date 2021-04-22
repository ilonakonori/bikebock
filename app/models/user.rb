class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable

  encrypts :email, :unconfirmed_email
  blind_index :email, :unconfirmed_email

  has_one_attached :profile_photo
  has_one_attached :bike_photo

  has_many :rides, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :blockings, dependent: :destroy

  has_one :tracking, dependent: :destroy
  has_one :account, dependent: :destroy

  acts_as_taggable_on :tags
  before_save :set_tags

  after_create :create_tracking
  after_create :create_account

  after_destroy :photos_destroy
  after_destroy :destroy_where_sender
  after_destroy :destroy_tags

  # validations
  validates :name, presence: true, uniqueness: true, length: { in: 2..20 }, format: { with: /\A[a-zA-Z]+\z/ }
  # validates :about_me, presence: true, length: { in: 90..190 }
  validates :interests, presence: true, length: { in: 10..200 }
  validates :profile_photo, presence: true
  validates :bike_photo, presence: true

  acts_as_favoritor

  def after_confirmation #send_welcome
    BikeBockMailer.welcome_email(self).deliver_now!
  end

  def self.create_tracking
    self.tracking.create!(location: 'http://localhost:3000/rides', location_time: Time.now)
  end

  def self.create_account
    self.account.create!
  end

  def online?
    last_seen > 1.minutes.ago
  end

  def last_online
    elapsed = (Time.now - last_seen)
    mins, secs = elapsed.divmod 60.0
    if mins.to_i > (60 * 24)
      day = "%3d"%[mins.to_i / (60 * 24), secs]
      day + ' day'.pluralize(day.to_i) + ' ago'
    elsif mins.to_i > 59
      hour = "%3d"%[mins.to_i / 60, secs]
      hour + ' hour'.pluralize(hour.to_i) + ' ago'
    else
      min = "%3d"%[mins.to_i, secs]
      min + ' minute'.pluralize(min.to_i) + ' ago'
    end
  end

  def set_tags
    self.tag_list = self.interests.split(/\W+/).map { |i| i.upcase.gsub(/#/, '') }
  end

  def photos_destroy
    profile_photo.purge
    bike_photo.purge
  end

  def destroy_where_sender
    Notification.where(action: 'Request', sender_id: id).destroy_all
    Booking.where(participant: id).each { |b| b.destroy unless b.ride_date > Time.now }
    Blocking.where(blocked_user: id).destroy_all
    Conversation.where(sender_id: id).each { |c| c.destroy unless User.where(id: c.recipient_id).present? }
    Conversation.where(recipient_id: id).each { |c| c.destroy unless User.where(id: c.sender_id).present? }
  end

  def destroy_tags
    ActsAsTaggableOn::Tag.where(taggings_count: 0).destroy_all
  end
end
