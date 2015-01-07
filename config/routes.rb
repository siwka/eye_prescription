Rails.application.routes.draw do

  root to: 'static_pages#home'
  match '/signup',  to: 'users#new', via: 'get'
  resources :users
end
