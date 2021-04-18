class Ride < ApplicationRecord
  belongs_to :user

  has_many :requests, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings

  has_one_attached :photo_1
  has_one_attached :photo_2
  has_one_attached :photo_3

  # validations
  validates :title, presence: true, uniqueness: true, length: { in: 2..26 }, format: { with: /[[:alpha:]]/ }
  validates :short_description, presence: true, length: { in: 50..900 }
  validates :number_of_people, presence: true, inclusion: { in: (1..5).map(&:to_s) }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :start_location, presence: true
  validates :end_location, presence: true
  validates :difficulty, presence: true, inclusion: { in: (1..5).map(&:to_s) }
  validates :available_dates, presence: true
  validates :photo_1, presence: true
  validates :photo_2, presence: true
  validates :photo_3, presence: true


  after_destroy :photos_destroy

  acts_as_favoritable

  def photos
    [photo_1, photo_2, photo_3]
  end

  def rating # sort
    reviews.empty? ? 0 : reviews.average(:rating).round
  end

  def avg_rating # view
    reviews.empty? ? '' : '★' * reviews.average(:rating).round
  end

  # validate time => custom method
  validate :start_time_cannot_be_greater_than_end_time

  def start_time_cannot_be_greater_than_end_time
    if start_time.present? && Time.parse(end_time.strftime("%H:%M")) < Time.parse(start_time.strftime("%H:%M"))
      errors.add(:start_time, "can't be greater than end_time")
    end
  end

  # calculate duration
  def duration
    (Time.parse(end_time.strftime("%H:%M")) - Time.parse(start_time.strftime("%H:%M"))) / 3600
  end

  # valid dates
  def valid_dates
    b = self.bookings.select(:ride_date).group(:ride_date).having("count(*) >= #{self.number_of_people.to_i}").select(:ride_date).size.map { |d| d[0] }
    s = self.available_dates.split(', ').map(&:to_date).select { |d| d >= Time.now }
    (b + s).select { |d| (b + s).count(d) == 1 }.sort
  end

  def self.total_valid(user) # don't display current_user ride, don't display rides with invalid dates
    # don't display rides of users that current_user blocked
    blocked_users = user.blockings.map { |b| b.blocked_user }
    # don't display rides of a users that blocked current_user
    user_blocked_by = Blocking.all.select do |b|
                        if b.blocked_user == user.id
                          b
                        end
                      end.map { |b| b.user_id }
    all.reject do |r|
      if r.user_id == user.id || !r.valid_dates.present? || blocked_users.include?(r.user_id) || user_blocked_by.include?(r.user_id)
        r
      end
    end
  end

   def photos_destroy
    photo_1.purge
    photo_2.purge
    photo_3.purge
  end

  # def self.total_valid
  #  all.select do |i|
  #    if i.valid_dates.present?
  #      i
  #   end
  #  end
  # end
end

