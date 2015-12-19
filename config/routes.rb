Rails.application.routes.draw do

  root 'stories#index'


  devise_for :users, controllers: {registrations: 'registrations'}
  resources :users, only: [:index, :show]

  resources :stories do
    get 'like', as: :like
    get 'dislike', as: :dislike
  end
  get 'stories' => 'stories#index'
  get 'search' => 'stories#search'
  get 'stories/:id/like' => 'stories#like'

  resources :messages


end
