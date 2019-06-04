Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'pages#home'
  get '/new', to: 'pages#new'
  get '/welcome', to: 'pages#welcome'
<<<<<<< HEAD
  get '/auth/:provider/callback', to: 'oauth#callback', as: 'oauth_callback'
  get '/auth/failure', to: 'oauth#failure', as: 'oauth_failure'
=======
  get '/loading', to: 'pages#loading'

  # get '/auth/:provider/callback', to: 'oauth#callback', as: 'oauth_callback'
  # get '/auth/failure', to: 'oauth#failure', as: 'oauth_failure'

>>>>>>> cda0b318de286e615c710f7ec0c17d58214f860c
  resources :user_skill
  resources :guest_users
  resources :jobs do
    resources :saved_jobs, only: [:new, :create]
  end
  resources :saved_jobs, only: :destroy
  resources :users, only: [:show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
