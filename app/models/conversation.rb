class Conversation < ApplicationRecord
  belongs_to :request
  has_many :messages
end
