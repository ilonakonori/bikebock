class Request < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'
  has_one :conversation, dependent: :destroy

  # validation not working? #change this to be select_date
  validates :first_message, presence: true

  # add ride id, validates :ride_id, uniqueness: { scope: :select_date } + sender_id
  # scope: [:sender_id, :select_date]

 # validates :sender_id, uniqueness: { scope: :recipient_id }

  #scope :between, -> (sender_id, recipient_id) do
  #  where(sender_id: sender_id, recipient_id: recipient_id).or(
   #   where(sender_id: recipient_id, recipient_id: sender_id)
   # )
  #end

  def opposed_user(user)
    user.id == recipient_id ? User.find(sender_id) : User.find(recipient_id)
  end
end
