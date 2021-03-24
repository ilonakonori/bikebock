class Request < ApplicationRecord
  belongs_to :user
  belongs_to :ride

  validates :ride_date, presence: true
  validates :user_id, presence: true
  validates :recipient_id, presence: true
  validates :ride_id, presence: true


  # add ride id, validates :ride_id, uniqueness: { scope: :select_date } + sender_id
  # scope: [:sender_id, :select_date]

  #validates :ride_date, uniqueness: { scope: [:user_id, :ride_id]}

  #scope :between, -> (sender_id, recipient_id) do
  #  where(sender_id: sender_id, recipient_id: recipient_id).or(
   #   where(sender_id: recipient_id, recipient_id: sender_id)
   # )
  #end

 # def opposed_user(user)
  #  user.id == recipient_id ? User.find(sender_id) : User.find(recipient_id)
  #end
end
