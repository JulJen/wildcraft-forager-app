Rails.application.routes.draw do

  root 'application#main'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/profile' => 'users#index'
  get '/dashboard' => 'users#show'

  get '/newteam' => 'teams#new'
  get '/teams/:name' => 'teams#show'

  get '/projects' => 'projects#index'
  get '/team/:id/project/:name' => 'projects#show'

  delete '/logout' => 'sessions#destroy'


  resources :users, :except => [:index, :show]

  resources :teams, :except => [:new, :show]

  resources :teams do
    resources :projects, :except => [:index]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
