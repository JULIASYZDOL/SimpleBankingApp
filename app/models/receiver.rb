class Receiver < ApplicationRecord
    belongs_to :user
    belongs_to :transaction
end