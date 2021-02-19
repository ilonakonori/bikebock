class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :recipient_id
      t.integer :sender_id
      t.references :conversation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
