class Message < ApplicationRecord
  belongs_to :conversation
  has_one_attached :attachment

  validates :content, presence: true, unless: ->(message){message.attachment.present?}
  validates :attachment, presence: true, unless: ->(message){message.content.present?}
end
