Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#play'
  # get 'records', to: 'pages#records'
  resources :games, only: [:index, :show]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :games, only: [] do
        resources :channels, only: [:index] do
          resources :messages, only: [:index, :create]
        end
      end
    end
  end

  mount ActionCable.server, at: '/cable'
end
