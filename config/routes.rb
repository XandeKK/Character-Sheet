Rails.application.routes.draw do
  root 'home#index'

  resources :characters, except: [:new]

  get 'gm', to: 'gm#index'
  get 'npcs', to: 'npcs#index'
  get 'enemies', to: 'enemies#index'
  resources :adventures
  
  get 'campaigns_tv', to: 'campaign_tv#index', as: 'campaigns_tv'
  get 'campaign_tv/:unique_name', to: 'campaign_tv#show', as: 'campaign_tv'
end
