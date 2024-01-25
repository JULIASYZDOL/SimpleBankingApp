class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :card_number
      t.string :identity_document

      t.timestamps
    end
  end
end
