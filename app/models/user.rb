class User < ApplicationRecord
    attr_encrypted :selected_characters, key: Figaro.env.secret_key
    attr_encrypted :identity_document, key: Figaro.env.secret_key
    attr_encrypted :card_number, key: Figaro.env.secret_key

    has_many :senders
    has_many :receivers
  
    has_secure_password
    has_many :accounts
    has_many :sent_transactions, class_name: 'Transaction', foreign_key: 'sender_id'
    has_many :received_transactions, class_name: 'Transaction', foreign_key: 'receiver_id'
    has_one :selected_characters_combination, class_name: 'PasswordCombination'
    has_many :password_combinations
  
    validates :username, presence: true, length: { maximum: 50 }
    validates :mail, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
    validates :password, length: { minimum: 8 }, format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%\^&\*])/, message: "must include lowercase, uppercase, digit and special character and should not be the same as username or email" }, exclusion: { in: ->(user) { [user.username, user.mail] }, message: "must include lowercase, uppercase, digit and special character and should not be the same as username or email" }
    validates :identity_document, presence: true, format: { with: /\A[A-Za-z]{3}\d{6}\z/ }
    validates :card_number, presence: true, uniqueness: true
  
    after_create :generate_and_save_password_combinations
    after_create :create_user_account

    def authenticate_with_selected_characters(selected_characters)
        stored_combination = password_combinations.sample
        stored_combination.authenticate(selected_characters)
    end
  
    def generate_and_save_password_combinations
      selected_characters = generate_random_selected_characters
      combination_data = {
        combination: selected_characters.join(''),
        character_positions: selected_characters_positions(selected_characters)
      }
  
      self.password_combinations.create(combination_data)
    end
  
    private
  
    def generate_random_selected_characters
      password.chars.sample(rand(3..6))
    end
  
    def selected_characters_positions(selected_characters)
      selected_characters.map { |char| password.index(char) + 1 }
    end

    def create_user_account
      account = Account.new(user: self)
      account.generate_account_number
      account.save
    end
  end
  