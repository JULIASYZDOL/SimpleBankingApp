class AddEncryptedFieldToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :account_number_ciphertext, :text
    add_column :accounts, :account_number_iv, :text
  end
end
