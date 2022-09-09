Rails.application.routes.draw do
  root 'home#index'
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"

  get 'player', to: 'player#index'
  
  resources :characters, path: '/player/characters', except: :index

  get 'gm', to: 'gm#index'
  scope '/gm' do
    resources :npcs
    resources :enemies
    resources :adventures
  end

  get 'tv', to: "tv#index"
end
