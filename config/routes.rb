Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
      post '/cards', to: 'cards#search'
      post '/cards/:id', to: 'cards#collect'
      get '/userCards', to: 'user_cards#index'
      delete '/userCards/:id', to: 'user_cards#destroy'
    end
  end
end
