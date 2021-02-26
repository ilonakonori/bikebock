class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :action
      t.integer :action_id
      t.string :sender_name
      t.string :content
      t.boolean :read, default: false
      t.datetime :read_at
      t.datetime :action_time

      t.timestamps
    end
  end
end
