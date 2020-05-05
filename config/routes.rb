Rails.application.routes.draw do
  resources :labels
  namespace :admin do
    resources :users
  end
  get "/login", to: "sessions#new"
  root to: "sessions#new"
  resources :tasks
  resources :users
  resources :sessions
  resources :midlabls, only:[:create,:destroy]
end
