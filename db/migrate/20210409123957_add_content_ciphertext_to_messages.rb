class AddContentCiphertextToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :content_ciphertext, :text
  end
end
