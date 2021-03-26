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

  def date_display # imp => time zone !!
    created_at.year == Time.now.year ? no_year : created_at.strftime("%Y, %b %e at %l:%M %p")
  end

  def no_year
    if created_at.day == Time.now.day
      created_at.strftime("%l:%M %p")
    elsif created_at.day == Time.now.day - 1
      created_at.strftime("Yesterday at %l:%M %p")
    else
      created_at.strftime("%b %e at %l:%M %p")
    end
  end
end
