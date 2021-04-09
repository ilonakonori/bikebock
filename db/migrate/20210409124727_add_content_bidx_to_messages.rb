class AddContentBidxToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :content_bidx, :string
    add_index :messages, :content_bidx
  end
end
