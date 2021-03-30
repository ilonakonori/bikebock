class Ride < ApplicationRecord
  belongs_to :user
  has_many_attached :photos #maximum: 3
  has_many :requests, dependent: :destroy
  has_many :bookings, dependent: :destroy


  before_save :build_slug
  before_update :build_slug

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
  validates :photos, presence: true

  acts_as_favoritable

  include PgSearch::Model
  pg_search_scope :search_rides, against: [
    [:title, 'A',
    :start_location,'B',
    :end_location, 'C',
    :short_description, 'D']
  ],
    using: {
      tsearch: { prefix: true }
    }

  def build_slug
    self.slug = available_dates.split(', ').map { |el| DateTime.parse(el) }.sort.first
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

  def self.total_valid
    all.select do |i|
      if i.valid_dates.present?
        i
      end
    end
  end
end

