class AddToTransactions < ActiveRecord::Migration[7.1]
  def change
    remove_reference :transactions, :sender
    remove_reference :transactions, :receiver

    change_table :transactions do |t|
      t.references :sender, null: false, foreign_key: { to_table: :accounts }
      t.references :receiver, null: false, foreign_key: { to_table: :accounts }
    end
  end
end
