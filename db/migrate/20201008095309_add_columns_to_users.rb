class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :about_me, :string
    add_column :users, :date_of_birth, :date
  end
end
