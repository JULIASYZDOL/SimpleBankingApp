class CreateReceivers < ActiveRecord::Migration[7.1]
  def change
    create_table :receivers do |t|
      t.string :name

      t.timestamps
    end
  end
end
