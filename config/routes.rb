Rails.application.routes.draw do
  devise_for :users
  # root to: 'pages#home'
  root to: 'rides#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: :show do
    member do
      get :presence
      put :presence
      get :unread
    end
    collection do
      get :bookmarks
      get :notifications
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

  resources :requests, only: [:index, :new, :create, :update, :show] do
    resources :conversations, only: :create
    resources :bookings, only: :create
  end

  resources :conversations, only: [:show, :index] do
    member do
      get :media
      get :search_messages
    end
    collection do
      get :search
    end
    resources :messages, only: :create
  end

  resources :tags, only: [:index, :show]
end
