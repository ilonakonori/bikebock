class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy

  def opposed_user(user)
    user.id == recipient_id ? User.find(sender_id) : User.find(recipient_id)
  end
end
