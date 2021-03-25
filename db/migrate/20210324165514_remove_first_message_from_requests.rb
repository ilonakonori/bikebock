class RemoveFirstMessageFromRequests < ActiveRecord::Migration[6.0]
  def change
    remove_column :requests, :first_message, :string
  end
end
