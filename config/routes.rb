Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/404', :to => 'application#not_found'
  get '/422', :to => 'application#unacceptable'
  get '/500', :to => 'application#internal_error'


  get '/auth/google_oauth2/callback', to: 'sessions#create'

  root 'application#welcome', :as => 'welcome'

  get '/projectmanageable' => 'application#enter', :as => 'enter'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  delete '/logout' => 'sessions#destroy', :as => 'logout'

  get '/dashboard/:id/liveteams' => 'public_teams#index', :as => 'liveteams'
  get '/dashboard/:id/liveprojects' => 'public_teams#show', :as => 'liveprojects'
  # index
  # new
  # create
  # show
  # edit
  # update
  # destroy


  delete '/teams/:id' => 'teams#destroy', :as => 'admin_team_delete'

  resources :users, path: :dashboard, shallow: true, except: %i[index new create destroy] do
    resources :teams, shallow: true
    # resources :projects, shallow: true
  end



  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/profile' => 'users#index', :as => 'profile'

  resources :team, only: %i[show] do
    resources :projects, shallow: true
      # resources :team_members, path: :myteam
    # end
  end

  resources :projects, only: %i[show] do
    resources :team_members, path: :myteam
  end

end
