Rails.application.routes.draw do
  root 'home#index'

  resources :characters
  get 'player', to: 'player#index'
  get 'gm', to: 'gm#index'
end
