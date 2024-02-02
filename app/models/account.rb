class Account < ApplicationRecord
  before_create :generate_account_number
  belongs_to :user
  has_many :sent_transactions, class_name: 'Transaction', foreign_key: 'sender_id'
  has_many :received_transactions, class_name: 'Transaction', foreign_key: 'receiver_id'

  attribute :balance, default: 100

  def generate_account_number
    self.account_number = generate_unique_account_number
  end

  def generate_unique_account_number
    loop do
      number = SecureRandom.hex(4).upcase
      return number unless Account.exists?(account_number: number)
    end
  end
end
