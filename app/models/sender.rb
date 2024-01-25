class Sender < ApplicationRecord
    belongs_to :user
    belongs_to :transaction
end