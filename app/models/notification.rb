class Notification < ApplicationRecord
  belongs_to :user

  def date_display # localtime
    updated_at.localtime.year == Time.now.year ? no_year : updated_at.localtime.strftime("%d %b %Y, at %l:%M %p")
  end

  def no_year
    if updated_at.localtime.day == Time.now.day
      updated_at.localtime.strftime("%l:%M %p")
    elsif updated_at.localtime.day == Time.now.day - 1
      updated_at.localtime.strftime("Yesterday at %l:%M %p")
    else
      updated_at.localtime.strftime("%d %b at %l:%M %p")
    end
  end
end
