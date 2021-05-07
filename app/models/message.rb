class Message < ApplicationRecord
  belongs_to :conversation
  has_one_attached :attachment
  encrypts :content #, type: :text => argument error: unknown type text
  blind_index :content, slow: true
  after_destroy :attachment_destroy

  validates :content, presence: true, unless: ->(message){message.attachment.present?}
  validates :attachment, presence: true, unless: ->(message){message.content.present?}

  def date_display # localtime
    created_at.localtime.year == Time.now.year ? no_year : created_at.localtime.strftime("%d %b %Y, at %l:%M %p")
  end

  def no_year
    if created_at.localtime.day == Time.now.day
      created_at.localtime.strftime("%l:%M %p")
    elsif created_at.localtime.day == Time.now.day - 1
      created_at.localtime.strftime("Yesterday at %l:%M %p")
    else
      created_at.localtime.strftime("%d %b at %l:%M %p")
    end
  end

  def attachment_destroy
    if attachment.attached?
      attachment.purge
    end
  end
end
