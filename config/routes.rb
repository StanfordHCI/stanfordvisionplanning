Rails.application.routes.draw do

  get 'regcodes/new'
  post 'regcodes/create'
  get 'sessions/new'

  root 'static_pages#home'
  get 'static_pages/home'

  get 'static_pages/help'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :ideas
  resources :regcodes
  resources :users
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :ideas, only: [:create, :update, :destroy, :index]
  mount Thredded::Engine => '/forum'
end
