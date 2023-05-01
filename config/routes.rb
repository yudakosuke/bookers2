Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:show, :edit, :index, :create, :destroy, :update]
  root to: "homes#top"
  get '/home/about', to: 'homes#about'
end
