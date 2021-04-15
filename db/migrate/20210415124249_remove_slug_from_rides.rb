class RemoveSlugFromRides < ActiveRecord::Migration[6.0]
  def change
    remove_column :rides, :slug, :date
  end
end
