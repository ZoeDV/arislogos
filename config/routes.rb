Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users, only: [:show, :new, :create, :update]
  
  resources :topics, only: [:show, :new, :create, :destroy]
  
  resources :posts, only: [:new, :create, :destroy]
  
  resources :interests, only: [:create, :destroy]
end
