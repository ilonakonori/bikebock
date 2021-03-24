class ChangeRideDateToTextInRequests < ActiveRecord::Migration[6.0]
  def change
    change_column :requests, :ride_date, :text
  end
end
