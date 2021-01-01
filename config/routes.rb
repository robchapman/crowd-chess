Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#play'
  get 'records', to: 'pages#records'

  namespace :api, defaults: { format: :json } do
  namespace :v1 do
    resources :channels, only: [] do
      resources :messages, only: [:index, :create]
      end
    end
  end
end
