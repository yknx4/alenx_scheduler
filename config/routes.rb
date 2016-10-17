Rails.application.routes.draw do
  devise_for :users, controllers: {
      registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepage#show'

  resources :users, only: [:show]

  constraints(Subdomain) do

    namespace :admin do
      resources :users
      resources :tenants
      resources :roles
      resources :users_roles

      root to: "users#index"
    end

    get '/': 'profiles#show'
  end
end
