class AddBikeTypeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :bike_type, :string
  end
end
