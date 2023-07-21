Rails.application.routes.draw do
  resources :projects
  resources :blogs
  resources :topics
  devise_for :users, controllers: { 
    registrations: 'users/registrations', 
    sessions: 'users/sessions' 
  }
  
  get 'userpage', to: 'pages#userpage'
  get 'user_check', to: 'pages#user_check'
  root 'pages#home'
end
