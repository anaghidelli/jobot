Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'pages#home'
  get '/new', to: 'pages#new'
  get '/welcome', to: 'pages#welcome'
  resources :user_skill
  resources :guest_users
  resources :jobs do
    resources :saved_jobs, only: [:new, :create]
  end
  resources :saved_jobs, only: :destroy
  resources :users, only: :show
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
