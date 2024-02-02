class AddEncryptedFieldToPasswordCombination < ActiveRecord::Migration[7.1]
  def change
    add_column :password_combinations, :combination_ciphertext, :text
    add_column :password_combinations, :combination_iv, :text
  end
end
