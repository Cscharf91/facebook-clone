Rails.application.routes.draw do
  get 'friend_request/new'
  get 'friend_request/create'
  get 'friend_request/destroy'
  get 'comments/create'
  resources :posts, only: [:index, :new, :create, :destroy, :show] do
    resources :likes
  end
  resources :comments, only: [:destroy]
  resources :friend_requests, only: [:new, :create, :destroy, :index]
  resources :friendships, only: [:create, :destroy]
  resources :users, only: [:index, :edit, :update] do
    member do
      get :friends, :profile
    end
  end

  post 'new_comment', to: 'posts#new_comment'
  
  devise_for :users, :controllers => { registrations: 'registrations', :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
