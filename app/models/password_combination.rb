class PasswordCombination < ApplicationRecord
    belongs_to :user
  
    serialize :character_positions, JSON
    validates :combination, presence: true

    attr_encrypted :combination, key: Figaro.env.secret_key

    def authenticate(selected_characters)
        entered_combination = selected_characters.is_a?(Array) ? selected_characters.join('') : selected_characters
        self.combination == entered_combination
    end
end