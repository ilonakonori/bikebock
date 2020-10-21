class Ride < ApplicationRecord
  belongs_to :user
  has_many_attached :photos

  # validations
  validates :title, presence: true, uniqueness: true, length: { in: 2..50 }, format: { with: /\A[a-zA-Z]+\z/ }
  validates :short_description, presence: true, length: { in: 20..600 }
  validates :number_of_people, presence: true, inclusion: { in: ["1-2", "3-4", "5 and more"] }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :start_location, presence: true
  validates :end_location, presence: true
  validates :difficulty, presence: true, inclusion: { in: %w(leisure easy intermediate advanced) }
  validates :available_dates, presence: true

  def duration
    end_time - start_time # wip
  end

  # validate time ..
end
