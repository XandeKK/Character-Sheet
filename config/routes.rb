Rails.application.routes.draw do
  root 'home#index'

  get 'player', to: 'player#index'
  resources :characters
  
  get 'gm', to: 'gm#index'
  get 'npcs', to: 'npcs#index'
end
