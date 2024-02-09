Rails.application.routes.draw do
  resources :gym_classes
  devise_for :users
  root 'home#index'
end
