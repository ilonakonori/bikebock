class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.references :ride, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :action_id
      t.integer :participant
      t.datetime :ride_date

      t.timestamps
    end
  end
end
