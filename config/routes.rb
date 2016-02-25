Rails.application.routes.draw do
  root "users#index"
  resources :tools
  resources :users, only: [:new, :create, :show]
  resources :categories, only: [:index, :show]

  get "/tools/random", to: "tools#random"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :admin do
    resources :categories, :tools
  end
end
