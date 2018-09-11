Rails.application.routes.draw do

  root 'application#main'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/profile' => 'users#index'
  get '/dashboard' => 'users#show'

  get '/teams/:name' => 'teams#show'

  delete '/logout' => 'sessions#destroy'


  resources :users, :except => [:index]

  resources :teams
  resources :projects

  resource :users do
    resources :teams, only: [:index, :new, :create]
  end
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
