class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy

  def user_present(user)
    User.where(id: sender_id).present? && User.where(id: recipient_id).present?
  end

  def opposed_user(user)
    user.id == recipient_id ? User.find(sender_id) : User.find(recipient_id)
  end

  def opposed_name(user)
    user.name == recipient_name ? sender_name : recipient_name
  end
end
