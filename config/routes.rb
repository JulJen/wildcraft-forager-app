Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/404', :to => 'errors#not_found'
  get '/422', :to => 'errors#unacceptable'
  get '/500', :to => 'errors#internal_error'


  match '/auth/google_oauth2/callback', to: 'sessions#create', via: [:get, :post]

  # get '/auth/google_oauth2/callback', to: 'sessions#create'

  root 'application#welcome', :as => 'welcome'

  get '/projectmanageable' => 'application#enter', :as => 'enter'

  get '/projectmanageable/signin' => 'sessions#new', :as => 'signin'
  post '/signin' => 'sessions#create'

  get '/projectmanageable/signup' => 'users#new', :as => 'signup'
  post '/projectmanageable/signup' => 'users#create'

  post '/signup' => 'users#create'

  # match '/signup', to: 'users#create',  via: [:get, :post]

  get '/profile' => 'users#index', :as => 'profile'
  get '/dashboard' => 'users#show', :as => 'dashboard'

  get '/users/:user_id/teams' => 'teams#index', :as => 'current_teams'
  delete '/users/:user_id/teams/:id' => 'teams#destroy', :as => 'admin_team_delete'


  delete '/logout' => 'sessions#destroy', :as => 'logout'

  # index
  # new
  # create
  # show
  # edit
  # update
  # destroy

  resources :users, only: %i[show] do
    resources :teams, shallow: true
    resources :projects
  end

  # resources :users, only: %i[dashboard] do
  #   resources :teams, shallow: true
  # end
  # #
  # # resources :users, only: %i[dashboard] do
  # #   resources :projects, shallow: true
  # # end
  resources :teams, only: %i[show] do
    resources :projects
  end

end
