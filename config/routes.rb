Rails.application.routes.draw do
  mount StripeEvent::Engine, at: '/stripe/hook'

  devise_for :users
  resources :projects, except: :show
  resources :videos
  resource :subscription
  resource :card
  
  root to: 'projects#index'

end
