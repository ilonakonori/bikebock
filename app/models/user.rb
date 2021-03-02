class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_photo
  has_one_attached :bike_photo
  has_many :rides, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one :tracking, dependent: :destroy

  after_create :create_tracking

  # validations
  validates :name, presence: true, uniqueness: true, length: { in: 2..20 }, format: { with: /\A[a-zA-Z]+\z/ }
  validates :about_me, presence: true, length: { in: 20..188 }
  validates :interests, presence: true, length: { in: 10..200 }
  validates :profile_photo, presence: true
  validates :bike_photo, presence: true

  acts_as_favoritor

  def self.create_tracking
    self.tracking.create!(location: 'http://localhost:3000/rides', location_time: Time.now)
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
end
