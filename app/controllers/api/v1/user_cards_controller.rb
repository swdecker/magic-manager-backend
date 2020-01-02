class Api::V1::UserCardsController < ApplicationController
    def index
        collection = current_user.cards
        @userCards = current_user.user_cards
        
        render json: @userCards.to_json(user_card_serializer)
        
    end

    def destroy
        @user_card = UserCard.find(params[:id])
        if @user_card
            @user_card.destroy
            render json:{message: 'Card removed'}, status: :accepted
        else
            render json: {message: 'Card not found'}, status: :no_content
        end
    end

    private 
    def user_card_serializer
        {
            :only => [:id, :card_id, :user_id, :num_owned],
            :include => [:card]
        }
    end
end