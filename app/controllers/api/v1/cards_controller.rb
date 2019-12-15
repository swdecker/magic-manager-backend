class Api::V1::CardsController < ApplicationController
    def search
        puts "searching for card #{card_params[:cardName]}"
        cards = MTG::Card.where(name: card_params[:cardName]).all
        # card = MTG::Card.find(88803)
        if cards[0] && cards[0].name == card_params[:cardName]
            puts '************'
            puts cards[0]
            puts '************'
        end
        if cards && cards.length > 0 
            i = 0
            while i < cards.length 
                if cards[i].name == card_params[:cardName] && cards[i].image_url
                    card = Card.find_or_create_by(name: cards[i].name)
                    card.image_url ||= cards[i].image_url
                    card.save
                    render json: {card: {
                        name:card.name,
                        image_url: card.image_url
                        }}, status: :accepted
                    break
                end
                i+=1
            end
        else
            render json: {message: 'Card not found'}, status: :no_content
        end
    end

    private

    def card_params
            params.require(:card).permit(:cardName)
    end
end
