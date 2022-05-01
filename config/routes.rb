Rails.application.routes.draw do
  resources :categories
  resources :posts do
    resources :comments
  end
  root 'posts#index'
end
