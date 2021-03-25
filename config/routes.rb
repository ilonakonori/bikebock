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

  resources :requests, only: [:index, :new, :create, :show, :destroy] do
    resources :conversations, only: :create
  end

  resources :conversations, only: [:show, :index] do
    collection do
      get :search
    end
    resources :messages, only: :create
    member do
      get :media
    end
  end

  resources :tags, only: :show
end
