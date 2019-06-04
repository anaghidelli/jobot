Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'pages#home'
  get '/new', to: 'pages#new'
  get '/welcome', to: 'pages#welcome'
  get '/auth/:provider/callback', to: 'oauth#callback', as: 'oauth_callback'
  get '/auth/failure', to: 'oauth#failure', as: 'oauth_failure'
  resources :user_skill
  resources :guest_users
  resources :jobs do
    resources :saved_jobs, only: [:new, :create]
  end
  resources :saved_jobs, only: :destroy
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
