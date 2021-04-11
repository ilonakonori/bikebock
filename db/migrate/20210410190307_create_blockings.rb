class CreateBlockings < ActiveRecord::Migration[6.0]
  def change
    create_table :blockings do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :blocked_user

      t.timestamps
    end
  end
end
