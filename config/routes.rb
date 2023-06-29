Rails.application.routes.draw do
  # mount ActionCable.server => 'chats#show'

  devise_for :users
  root to: "pages#home"
  get "profile", to: "pages#profile" #for users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :user_favourites, only: [:index]


  resources :businesses do
    resources :user_favourites, only: [:create]
    resources :reviews, only: [:create]
  end # refactored resources code.


  resources :reviews, only: [:destroy]

  resources :chats, only: [:show, :index] do
    resources :messages, only: [:create], param: :chat_id
  end
end
