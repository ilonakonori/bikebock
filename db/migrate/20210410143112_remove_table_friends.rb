class RemoveTableFriends < ActiveRecord::Migration[6.0]
  def up
    drop_table :friends
  end
end
