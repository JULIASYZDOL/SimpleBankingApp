class AddEncryptedIdentityDocumentToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :encrypted_identity_document, :text
    add_column :users, :encrypted_identity_document_iv, :text
  end
end
