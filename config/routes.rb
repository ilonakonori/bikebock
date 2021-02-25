Rails.application.routes.draw do
  devise_for :users
  # root to: 'pages#home'
  root to: 'rides#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: :show do
    member do
      get :presence
    end
  end

  resources :rides do
    member do
      get :fav
      put :fav
      get :unfav
      put :unfav
    end
  end

  resources :requests, only: [:new, :create, :show] do
    resources :conversations, only: [:new, :create]
  end

  resources :conversations, only: [:show, :index] do
    resources :messages, only: :create
  end
end
