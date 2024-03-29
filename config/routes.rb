Rails.application.routes.draw do
  
  apipie

  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  root to: 'apipie/apipies#index'

  namespace :v1, defaults: {format: 'json'} do
    resources :sessions, only: [:create, :destroy]

    resources :users, only: [:show, :create, :index], param: :userId
  end
  
end
