class AddColumnsToRequests < ActiveRecord::Migration[6.0]
  def change
    add_reference :requests, :ride, null: false, foreign_key: true
    add_reference :requests, :user, null: false, foreign_key: true
    add_column :requests, :ride_date, :date
  end
end
