Rails.application.routes.draw do
  resources :bookings
  resources :gym_classes
  devise_for :users
  root 'home#index'
end
