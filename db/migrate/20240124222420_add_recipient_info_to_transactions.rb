class AddRecipientInfoToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :recipient_name, :string
  end
end
