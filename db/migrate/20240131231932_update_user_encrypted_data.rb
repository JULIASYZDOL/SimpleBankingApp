class UpdateUserEncryptedData < ActiveRecord::Migration[7.1]
  def change
    def up
      User.find_each do |user|
        user.update_columns(
          identity_document: user.encrypted_identity_document,
          card_number: user.encrypted_card_number
        )
      end
    end
  end
end
