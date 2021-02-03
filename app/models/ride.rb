class Ride < ApplicationRecord
  belongs_to :user
  has_many_attached :photos #maximum: 3

  # validations
  validates :title, presence: true, uniqueness: true, length: { in: 2..100 }, format: { with: /[[:alpha:]]/ }
  validates :short_description, presence: true, length: { in: 50..900 }
  validates :number_of_people, presence: true, inclusion: { in: (1..5).map(&:to_s) }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :start_location, presence: true
  validates :end_location, presence: true
  validates :difficulty, presence: true, inclusion: { in: (1..5).map(&:to_s) }
  validates :available_dates, presence: true
  validates :photos, presence: true

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
end
