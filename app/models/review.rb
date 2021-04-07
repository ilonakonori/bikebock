class Review < ApplicationRecord
  belongs_to :booking

  validates :content, presence: true
  validates :rating, presence: true, inclusion: { in: (1..5).to_a, message: "please give a rating of 1-5" }, numericality: { only_integer: true }

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
