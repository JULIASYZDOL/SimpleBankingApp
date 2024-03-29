class Transaction < ApplicationRecord
  belongs_to :sender, class_name: 'Account', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'Account', foreign_key: 'receiver_id'

  validates :sender, presence: true
  validates :receiver, presence: true
end
