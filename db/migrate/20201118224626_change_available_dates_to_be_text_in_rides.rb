class ChangeAvailableDatesToBeTextInRides < ActiveRecord::Migration[6.0]
  def change
    change_column :rides, :available_dates, :text
  end
end
