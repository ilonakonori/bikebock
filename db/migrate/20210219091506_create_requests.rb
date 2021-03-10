class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.string :first_message
      t.boolean :accepted, default: false
      t.boolean :friend, default: false

      t.timestamps
    end
    add_index :requests, :recipient_id
    add_index :requests, :sender_id
    add_index :requests, [:recipient_id, :sender_id], unique: true
  end
end

# change this scope
