class Review < ApplicationRecord
  belongs_to :booking

  validates :content, presence: true
  validates :rating, presence: true, inclusion: { in: (1..5).to_a, message: "please give a rating of 1-5" }, numericality: { only_integer: true }
end
