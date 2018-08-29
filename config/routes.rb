Rails.application.routes.draw do

  root 'application#main'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/profile' => 'users#index'
  delete '/logout' => 'sessions#destroy'

  resources :users
  resources :teams
  resources :projects

  # resource :users, only: [:index, :show] do
  #   resources :teams, only: [:index, :new, :create]
  # end
  #
  # resources :teams, only: [:show, :edit, :update, :destroy]
  #
  # resources :teams do
  #   resources :projects , only: [:index, :show]
  # end
  #
  # resources :projects, only: [:show, :edit, :update, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
