class Conversation < ApplicationRecord
  belongs_to :request
  has_many :messages

  def opposed_user(user)
    user.id == recipient_id ? User.find(sender_id) : User.find(recipient_id)
  end
end
