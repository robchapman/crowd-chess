Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#play'
  # get 'records', to: 'pages#records'
  resources :games, only: [:index, :show]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :games, only: [:create] do
        resources :channels, only: [:index] do
          resources :messages, only: [:index, :create]
        end
        resources :board, only: [:index]
        resources :moves, only: [:index, :create]
        resources :plays, only: [:update, :show]
        post 'plays/:id/beacon', to: 'plays#beacon'
        get 'latest/', to: 'games#latest'
      end
    end
  end

  mount ActionCable.server, at: '/cable'
end
