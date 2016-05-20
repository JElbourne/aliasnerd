Rails.application.routes.draw do
  devise_for :users
  resources :projects, except: :show
  resources :videos
  resource :subscription
  
  root to: 'projects#index'

end
