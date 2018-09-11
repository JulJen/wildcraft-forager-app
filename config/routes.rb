Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/auth/google_oauth2/callback', to: 'sessions#create'

  root 'application#main'
  get '/success', to: 'application#success'

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

  resources :users do
    resources :teams, :only => [:index]
  end

  resources :teams do
    resources :projects, :except => [:index]
  end

end
