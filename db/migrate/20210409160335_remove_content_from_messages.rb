class RemoveContentFromMessages < ActiveRecord::Migration[6.0]
  def change
    remove_column :messages, :content, :text
  end
end
