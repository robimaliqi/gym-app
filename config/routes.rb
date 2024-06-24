Rails.application.routes.draw do
  resources :subscriptions
  resources :bookings
  resources :gym_classes
  devise_for :users
  root 'home#index'

  get '/payment_method_selection', to: 'subscriptions#payment_method_selection'
  post '/pay_as_you_go', to: 'subscriptions#pay_as_you_go'
  post '/pay_monthly', to: 'subscriptions#pay_monthly'
  get '/checkout', to: 'subscriptions#stripe_checkout'
  get '/checkout/success', to: 'subscriptions#checkout_success', as: 'checkout_success'
  get '/checkout/cancel', to: 'subscriptions#checkout_cancel', as: 'checkout_cancel'
end
