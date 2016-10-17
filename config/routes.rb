Rails.application.routes.draw do

  constraints(subdomain: '') do
    constraints(host: /^(?!www\.)/i) do
      get '' => redirect { |params, request|
        URI.parse(request.url).tap { |uri| uri.host = "www.#{uri.host}" }.to_s
      }
    end
  end

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
