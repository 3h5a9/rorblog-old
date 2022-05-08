# frozen_string_literal: true

# Routes
Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :posts do
    member do
      patch 'upvote', to: 'posts#upvote'
      patch 'downvote', to: 'posts#downvote'
    end
    resources :comments

    collection do
      get :search
    end
  end

  root 'posts#index'
end