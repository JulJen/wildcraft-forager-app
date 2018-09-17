Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/404', :to => 'errors#not_found'
  get '/422', :to => 'errors#unacceptable'
  get '/500', :to => 'errors#internal_error'


  match '/auth/google_oauth2/callback', to: 'sessions#create', via: [:get, :post]

  # get '/auth/google_oauth2/callback', to: 'sessions#create'

  root 'application#welcome', :as => 'welcome'

  get '/projectmanageable' => 'application#enter', :as => 'enter'

  # get '/projectmanageable/signin' => 'sessions#new', :as => 'signin'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'

  # get '/projectmanageable/signup' => 'users#new', :as => 'signup'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  # match '/signup', to: 'users#create',  via: [:get, :post]

  get '/profile' => 'users#index'

  # get '/users/:id' => 'users#show', :as => 'dashboard'
  get '/dashboard' => 'users#show', :as => 'dashboard'

  get '/dashboard/:user_id/teams' => 'teams#index', :as => 'current_teams'
  delete '/dashboard/:user_id/teams/:id' => 'teams#destroy', :as => 'admin_team_delete'

  delete '/logout' => 'sessions#destroy', :as => 'logout'

  # index
  # new
  # create
  # show
  # edit
  # update
  # destroy

  resources :users, path: :dashboard,  except: %i[index, new, destroy]
  get '/dashboard/:id' => 'users#show'

  resources :users, path: :dashboard,  only: %i[show] do
    resources :teams
    resources :projects
  end

  # resources :users, only: %i[dashboard] do
  #   resources :teams, shallow: true
  # end
  # #
  # # resources :users, only: %i[dashboard] do
  # #   resources :projects, shallow: true
  # # end
  resources :teams, path: :dashboard,  only: %i[show] do
    resources :projects
  end

end
