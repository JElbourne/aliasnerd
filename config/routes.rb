Rails.application.routes.draw do
  mount StripeEvent::Engine, at: '/stripe/hook'

  devise_for :users
  resources :projects, except: :show
  resources :videos
  resource :subscription

  resource :card
  resource :config_nerd, only: [:edit, :update], path: "admin"
 
  get "/search", to: "search#index", as: "search" 
  post "/liked", to: "votes#vote_up", as: "vote_up"
  root to: 'welcome#index'

end
