Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: :show
  resources :rides do
    member do
      get :fav
      put :fav
      get :unfav
      put :unfav
    end
    collection do
      get :my_rides
    end
  end
end
