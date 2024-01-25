class CreateSensitiveData < ActiveRecord::Migration[7.1]
  def change
    create_table :sensitive_data do |t|
      t.string :card_number
      t.string :identity_document
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
