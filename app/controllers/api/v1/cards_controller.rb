class Api::V1::CardsController < ApplicationController
    def search
        card_name = card_params[:cardName]
        puts "searching for card #{card_name}"
        

        # check db first before sending fetch
        card = Card.find_by(name: card_name)
        # unless the card is in the database, fetch for the card by name

        unless card 
            cards = MTG::Card.where(name: card_params[:cardName]).all
            puts cards
            if cards && cards.length > 0 
                i = 0
                while i < cards.length 
                    # if more fields are added to card, need to update this check
                    # should also reset database so that full data will be stored
                    if cards[i].name == card_params[:cardName] && cards[i].image_url
                        card = Card.new(name: cards[i].name)
                        card.image_url = cards[i].image_url
                        card.save
                        break
                    end
                    i+=1
                end
            end
        end
        if card
            render json: {
                card: {
                    id: card.id,
                    name:card.name,
                    image_url: card.image_url
                }
            }, status: :accepted
        else
            render json: {message: 'Card not found'}, status: :no_content
        end
    end

    def collect
        card = Card.find(params[:id])
        user_cards = UserCard.where(user:current_user)
        puts user_cards
        already_owned = user_cards.select{|user_card| user_card.card_id == card.id}
        puts already_owned
        if already_owned.length>0
            user_card = already_owned.first
            user_card.num_owned += user_card_params[:card][:num_owned].to_i
        else
            user_card = UserCard.new(card: card, user: current_user, num_owned: user_card_params[:card][:num_owned]) 
        end

        if user_card.save
            render json: user_card, status: :accepted
        else
            render json: {message: "unable to add card"}, status: :bad_request
        end
    end

    private

    def card_params
            params.require(:card).permit(:cardName)
    end
    def user_card_params
        user = params.require(:user).permit(:id)
        card = params.require(:card).permit(:id, :num_owned)
        return {user: user, card: card}
    end
end
