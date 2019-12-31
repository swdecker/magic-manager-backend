class User < ApplicationRecord
    has_secure_password
    validates :username, uniqueness: { case_sensitive: false}
    
    has_many :decks
    has_many :card_searches
    has_many :user_cards
    has_many :cards, through: :user_cards
end
