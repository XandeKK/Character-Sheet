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

  resources :characters, path: '/characters/:category'
  get "characters", to: "characters#group", as: "characters_group"
  put "/hit_point", to: "characters#update_hp"

  resources :adventures
  post :adventure_participation, to: "adventure_participation#create"
  delete :adventure_participation, to: "adventure_participation#destroy"
    
  get 'tv', to: "tv#index"
end
