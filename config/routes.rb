Rails.application.routes.draw do

  root 'stories#index'


  devise_for :users, controllers: {registrations: 'registrations'}
  resources :users, only: [:show]

  resources :stories do
    get 'like', as: :like
    get 'dislike', as: :dislike
  end
  get 'stories' => 'stories#index'
  get 'search' => 'stories#search'
  get 'stories/:id/like' => 'stories#like'

  resources :messages
  get 'informations' => 'messages#informations'


end
