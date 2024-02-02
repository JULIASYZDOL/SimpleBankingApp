class AddEncryptedFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :account_number_ciphertext, :text
    add_column :users, :account_number_iv, :text
    add_column :users, :card_number_ciphertext, :text
    add_column :users, :card_number_iv, :text
  end
end
