class Api::V1::UserCardsController < ApplicationController
    def index
        collection = current_user.cards
        render json: { cards: collection }
    end

end