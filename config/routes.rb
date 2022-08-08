Rails.application.routes.draw do
  root 'home#index'

  resources :characters, except: [:new]
  put 'character/update_all_life', to: 'characters#update_all_life', as: 'character_update_all_life'

  get 'gm', to: 'gm#index'
  get 'npcs', to: 'npcs#index'
  get 'enemies', to: 'enemies#index'
  resources :adventures
  post 'adventure_participation/:id', to: 'adventure_participation#create', as: 'create_adventure_participation'
  delete 'adventure_participation/:id', to: 'adventure_participation#destroy', as: 'destroy_adventure_participation'
  
  get 'tv', to: 'campaign_tv#show', as: 'campaign_tv'
  post 'tv/sign_up', to: 'campaign_tv#create', as: 'sign_up_campaign_tv'
end
