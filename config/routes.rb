Rails.application.routes.draw do
  get 'users/new'

  root 'static_pages#home'
  get '/about',   to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/plans',    to: 'static_pages#plan'
  get '/signup',  to: 'users#new'
  resources :users
end