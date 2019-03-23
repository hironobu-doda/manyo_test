Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  # get 'sessions/new'
  # get 'tasks/index'

  root 'tasks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks

  resources :users, only: [:new, :create,:show]

  resources :sessions, only: [:new, :create, :destroy]

  resources :labels

  resources :tasklabels, only: [:create, :destroy]
end
