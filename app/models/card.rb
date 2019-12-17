class Card < ApplicationRecord
    has_many :deck_cards
    has_many :user_cards
end
