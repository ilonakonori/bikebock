class AddLinkToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :link, :string
  end
end
