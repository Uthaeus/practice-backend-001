Rails.application.routes.draw do
  
  get 'userpage', to: 'pages#userpage'
  get 'user_check', to: 'pages#user_check'
  root 'pages#home'
end
