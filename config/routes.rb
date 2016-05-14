Rails.application.routes.draw do
  devise_for :users
  resources :projects, except: :show
  
  root to: 'projects#index'

end
