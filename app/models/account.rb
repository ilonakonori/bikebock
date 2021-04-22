class Account < ApplicationRecord
  belongs_to :user
  validates :theme, presence: true, inclusion: { in: ['light-mode', 'dark-mode'] }
end
