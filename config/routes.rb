Rails.application.routes.draw do
  root 'home#index'

  get 'player', to: 'player#index'
  get 'player/campaigns_player', to: 'campaign_player#index', as: 'campaigns_player'
  get 'player/campaign_player/:unique_name', to: 'campaign_player#show', as: 'campaign_player'

  resources :characters
  
  get 'gm', to: 'gm#index'
  get 'npcs', to: 'npcs#index'
  get 'enemies', to: 'enemies#index'
  resources :adventures
end
