Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :posts do
    resources :comments
  end
  root 'posts#index'
end
