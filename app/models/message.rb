class Message < ApplicationRecord
  belongs_to :conversation
  has_one_attached :attachment

  validates :content, presence: true, unless: ->(message){message.attachment.present?}
  validates :attachment, presence: true, unless: ->(message){message.content.present?}

  # pg_search
  include PgSearch::Model
  pg_search_scope :search_content,
  against: [:content],
  using: {
    tsearch: { prefix: true }
  }

  def date_display # localtime
    created_at.localtime.year == Time.now.year ? no_year : created_at.localtime.strftime("%Y, %b %e at %l:%M %p")
  end

  def no_year
    if created_at.localtime.day == Time.now.day
      created_at.localtime.strftime("%l:%M %p")
    elsif created_at.localtime.day == Time.now.day - 1
      created_at.localtime.strftime("Yesterday at %l:%M %p")
    else
      created_at.localtime.strftime("%b %e at %l:%M %p")
    end
  end
end
