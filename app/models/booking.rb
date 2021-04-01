class Booking < ApplicationRecord
  belongs_to :ride
  belongs_to :user
  has_one :review, dependent: :destroy
end
