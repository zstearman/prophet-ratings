Rails.application.routes.draw do
  root 'static_pages#coming_soon'
  get 'team_seasons/index'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get 'users/new'
  get    '/about',     to: 'static_pages#about'
  get    '/contact',   to: 'static_pages#contact'
  get    '/plans',     to: 'static_pages#plan'
  get    '/dashboard', to: 'static_pages#dashboard'
  get    '/signup',    to: 'users#new'
  post   '/signup',    to: 'users#create'
  get    '/login',     to: 'sessions#new'
  post   '/login',     to: 'sessions#create'
  delete '/logout',    to: 'sessions#destroy'
  get    '/rankings',  to: 'team_seasons#index'
  get    '/stats',     to: 'team_seasons#stats'
  resources :games,               only:[:show]
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :conferences,         only: [:index, :show]
  resources :teams
end