class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :mail, :string
  end
end
