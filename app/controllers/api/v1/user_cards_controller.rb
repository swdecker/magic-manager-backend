class Api::V1::UserCardsController < ApplicationController
    def index
        collection = current_user.cards
        @userCards = current_user.user_cards
        # collected_cards = current_user.cards.map do |card|
        #     return {name: card.name, }
        # end
        puts @userCards.to_json(user_card_serializer)
        render json: @userCards.to_json(user_card_serializer)
        # { cards: collection, userCards: UserCardSerializer.new(userCards) }
    end

    private 
    def user_card_serializer
        {
            :only => [:id, :card_id, :user_id, :num_owned],
            :include => [:card]
        }
    end
end