class Message < ApplicationRecord
  belongs_to :conversation
  has_one_attached :attachment

  validates :content, presence: true, unless: ->(message){message.attachment.present?}
  validates :attachment, presence: true, unless: ->(message){message.content.present?}

  #def download_link
    #Cloudinary::Utils.private_download_url self.cloudinary_id, self.format, attachment: true
  #end
end
