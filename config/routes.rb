Rails.application.routes.draw do
  resources :sessions
  devise_for :users
  root 'home#index'
end
