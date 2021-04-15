class AddSenderNameAndRecipientNameToConversations < ActiveRecord::Migration[6.0]
  def change
    add_column :conversations, :sender_name, :string
    add_column :conversations, :recipient_name, :string
  end
end
