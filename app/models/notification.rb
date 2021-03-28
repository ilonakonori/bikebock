class Notification < ApplicationRecord
  belongs_to :user

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
