class RemoveDateOfBirthAndBikeTypeFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :date_of_birth, :date
    remove_column :users, :bike_type, :string
  end
end
