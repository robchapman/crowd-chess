Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'

  get 'play', to: 'pages#play'

  get 'records', to: 'pages#records'
end
