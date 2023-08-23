Rails.application.routes.draw do

  devise_for :users
  root to: "pages#home"
  get "profile", to: "pages#profile" #for users


  resources :user_favourites, only: [:index]


  resources :businesses do
    resources :user_favourites, only: [:create]
    resources :reviews, only: [:create]
  end 


  resources :reviews, only: [:destroy]

  resources :chats, only: [:show] do
    resources :messages, only: [:create], param: :chat_id
  end
end
