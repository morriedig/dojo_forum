Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admins do
    resources :post_categories
    resources :users, only: [:index, :show]
    post "change_role", to: "users#change_role"
    root "post_categories#index"
  end

  namespace :api do
    namespace :v1, defaults: {format: :json} do
      resources :posts
      post "login" => "auth#login"
      post "logout" => "auth#logout"
    end
  end

  resources :posts do
    resources :replies, only: [:create, :update, :destroy]
  end

  resources :replies, only: [:create, :update, :destroy, :edit ]

  resources :collection_posts, only: [:create, :destroy]
  resources :users, only: [:show, :index, :edit, :update]
  post "friend_ship", to: "users#friend_ship"
  post "remove_friendship" => "users#remove_friendship"

  get "feed", to: "posts#feed"
  root "posts#index"
end
