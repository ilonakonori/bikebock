class AddUnconfirmedEmailCiphertextAndBidxToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :unconfirmed_email_ciphertext, :text

    # blind index
    add_column :users, :unconfirmed_email_bidx, :string
    add_index :users, :unconfirmed_email_bidx
  end
end
