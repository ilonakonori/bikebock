class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  after_create :create_friends

  def create_friends
    Friend.create!(user_id: recipient_id, friend_id: sender_id)
    Friend.create!(user_id: sender_id, friend_id: recipient_id)
  end

  def opposed_user(user)
    user.id == recipient_id ? User.find(sender_id) : User.find(recipient_id)
  end
end
