Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/404', :to => 'errors#not_found'
  get '/422', :to => 'errors#unacceptable'
  get '/500', :to => 'errors#internal_error'


  # match '/auth/google_oauth2/callback', to: 'sessions#create', via: [:get, :post]

  get '/auth/google_oauth2/callback', to: 'sessions#create'

  root 'application#welcome', :as => 'welcome'

  get '/projectmanageable' => 'application#enter', :as => 'enter'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  delete '/logout' => 'sessions#destroy', :as => 'logout'

  get '/dashboard/:id/teamboard' => 'team_board#index', :as => 'teamboard'



  # index
  # new
  # create
  # show
  # edit
  # update
  # destroy

  # resources :users, path: :signup, only: %i[new create]

  delete '/teams/:id' => 'teams#destroy', :as => 'admin_team_delete'

  resources :users, path: :dashboard, shallow: true, except: %i[index new create destroy] do
    resources :teams, shallow: true
    # resources :projects, shallow: true
  end


  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/profile' => 'users#index', :as => 'profile'
  get '/dashboard' => 'users#show'


  resources :team, only: %i[show] do
    resources :projects, shallow: true
  end

  resources :projects, only: %i[show] do
    resources :team_members, path: :myteam
  end

  # resources :projects, only: %i[show edit update destroy]

  # resources :users, path: :dashboard, only: %i[edit update destroy]
  # get '/dashboard/:id' => 'users#show', :as => 'dashboard'


  #
  # resources :users, path: :dashboard, only: %i[show] do
  #   resources :teams, except: %i[index, show], shallow: true
  # end

end
