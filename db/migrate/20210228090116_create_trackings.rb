class CreateTrackings < ActiveRecord::Migration[6.0]
  def change
    create_table :trackings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :location
      t.datetime :location_time

      t.timestamps
    end
  end
end
