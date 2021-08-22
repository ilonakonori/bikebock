require 'rails_helper'

RSpec.describe Message, type: :model do
  it { is_expected.to belong_to(:conversation) }
  it { is_expected.to have_one_attached(:attachment) }
end

  ## 
  # validates :content, presence: true, unless: ->(message){message.attachment.present?}
  # validates :attachment, presence: true, unless: ->(message){message.content.present?}