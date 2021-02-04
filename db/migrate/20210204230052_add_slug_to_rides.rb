class AddSlugToRides < ActiveRecord::Migration[6.0]
  def change
    add_column :rides, :slug, :date
  end
end
