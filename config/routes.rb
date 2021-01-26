Rails.application.routes.draw do
  root 'users#index'

  post 'login', to: 'sessions#create'
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'

  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
