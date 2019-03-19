Rails.application.routes.draw do
  namespace :admin do
    get 'users/new'
    get 'users/edit'
    get 'users/show'
    get 'users/index'
  end
  # get 'sessions/new'
  # get 'tasks/index'

  root 'tasks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks

  resources :users, only: [:new, :create,:show]

  resources :sessions, only: [:new, :create, :destroy]
end
