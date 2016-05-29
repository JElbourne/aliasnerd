Rails.application.routes.draw do
  mount StripeEvent::Engine, at: '/stripe/hook'

  devise_for :users
  resources :projects, except: :show
  resources :videos
  resource :subscription
  resource :card
 
  get "/search", to: "search#index", as: "search" 
  patch "/liked", to: "users#liked", as: "liked"
  root to: 'welcome#index'

end
