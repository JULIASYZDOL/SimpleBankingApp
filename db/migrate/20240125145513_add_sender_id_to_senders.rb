class AddSenderIdToSenders < ActiveRecord::Migration[7.1]
  def change
    add_column :senders, :sender_id, :integer
  end
end
