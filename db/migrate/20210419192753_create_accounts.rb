class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :subscribed, default: false
      t.string :theme, default: 'light-mode'
      t.boolean :email_notification, default: true

      t.timestamps
    end
  end
end
