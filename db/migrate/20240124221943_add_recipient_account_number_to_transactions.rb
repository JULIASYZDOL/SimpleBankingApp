class AddRecipientAccountNumberToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :recipient_account_number, :string
  end
end
