Rails.application.routes.draw do
  get 'team_seasons/index'

  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get 'users/new'
  root 'static_pages#home'
  get    '/about',    to: 'static_pages#about'
  get    '/contact',  to: 'static_pages#contact'
  get    '/plans',    to: 'static_pages#plan'
  get    '/signup',   to: 'users#new'
  post   '/signup',   to: 'users#create'
  get    '/login',    to: 'sessions#new'
  post   '/login',    to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'
  get    '/rankings', to: 'team_seasons#index'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :teams
end