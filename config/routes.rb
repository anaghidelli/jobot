Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  authenticated :user do
    root 'users#show', as: :authenticated_root
  end
  root to: 'pages#home'
  get '/new', to: 'pages#new'
  get '/welcome', to: 'pages#welcome'
  get '/loading', to: 'pages#loading'

  # get '/auth/:provider/callback', to: 'oauth#callback', as: 'oauth_callback'
  # get '/auth/failure', to: 'oauth#failure', as: 'oauth_failure'

  resources :user_skill
  resources :guest_users
  resources :jobs do
    resources :saved_jobs, only: [:new, :create]
  end
  resources :saved_jobs, only: :destroy
  resources :users, only: [:show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
