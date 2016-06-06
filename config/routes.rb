Rails.application.routes.draw do
  mount StripeEvent::Engine, at: '/stripe/hook'

  devise_for :users
  resources :projects, except: :show
  resources :videos
  if Rails.env.production?
    constraints(:host => /herokuapp.com/) do
      resource :subscription
    end
  else
    resource :subscription
  end

  resource :card
 
  get '/subscription/new', to: redirect('https://aliasnerd.herokuapp.com/subscription/new')
  get '/subscription/edit', to: redirect('https://aliasnerd.herokuapp.com/subscription/edit')
  get "/search", to: "search#index", as: "search" 
  post "/liked", to: "votes#vote_up", as: "vote_up"
  root to: 'welcome#index'

end
