class ChangeShortDescriptionToBeTextInRides < ActiveRecord::Migration[6.0]
  def change
    change_column :rides, :short_description, :text
  end
end
