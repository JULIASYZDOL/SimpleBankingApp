class AddBalanceToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :balance, :integer, default: 100
  end
end
