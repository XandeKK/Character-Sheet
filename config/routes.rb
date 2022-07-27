Rails.application.routes.draw do
  root 'home#index'

  resources :characters, except: [:new, :edit]
  post 'edit/character/:id', to: 'characters#edit', as: 'edit_character'
  
  get 'player', to: 'player#index'
  get 'player/campaigns_player', to: 'campaign_player#index', as: 'campaigns_player'
  get 'player/campaign_player/:unique_name', to: 'campaign_player#show', as: 'campaign_player'

  get 'gm', to: 'gm#index'
  get 'npcs', to: 'npcs#index'
  get 'enemies', to: 'enemies#index'
  resources :adventures
  
  get 'campaigns_tv', to: 'campaign_tv#index', as: 'campaigns_tv'
  get 'campaign_tv/:unique_name', to: 'campaign_tv#show', as: 'campaign_tv'
end
