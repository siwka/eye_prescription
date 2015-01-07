Rails.application.routes.draw do

  root  to: 'static_pages#home'
  match '/signup',  to: 'users#new',        via: 'get'
  match '/login',		to: 'sessions#new',     via: 'get'
  match '/login',   to: 'sessions#create',  via: 'post'
  match '/logout',  to: 'sessions#destroy', via: 'delete'
  resources :users
end
