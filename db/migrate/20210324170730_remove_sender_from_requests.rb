class RemoveSenderFromRequests < ActiveRecord::Migration[6.0]
  def change
    remove_column :requests, :sender_id, :integer
  end
end
