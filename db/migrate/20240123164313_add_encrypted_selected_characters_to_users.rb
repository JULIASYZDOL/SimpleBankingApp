class AddEncryptedSelectedCharactersToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :encrypted_selected_characters, :text
  end
end
