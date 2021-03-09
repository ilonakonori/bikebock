class CreateFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :friends do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :friend_id

      t.timestamps
    end
    add_index :friends, :friend_id
    add_index :friends, [:user_id, :friend_id], unique: true
  end
end
