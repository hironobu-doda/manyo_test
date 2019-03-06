Rails.application.routes.draw do
  get 'tasks/index'

  root 'tasks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks
end
