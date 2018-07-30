Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admins do
    resources :post_categories
    resources :users, only: [:index, :show]
    post "change_role", to: "users#change_role"

    root "post_categories#index"
  end

  resources :posts do
    resources :replies
  end

  root "posts#index"
end
