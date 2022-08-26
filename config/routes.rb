Rails.application.routes.draw do

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  root to: "pages#home"

  get "my_offers", to: "offers#my_offers"

  resources :users, only: [:show]

  resources :bookings, only: [] do
    member do
      get :accept
      get :decline
    end
  end

  resources :offers do
    resources :bookings, only: %i[new create edit update destroy]
    resources :reviews, only: [:new, :create]
  end
  resources :bookings, only: %i[index show]
end
