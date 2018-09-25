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

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/dashboard' => 'users#index', :as => 'main'

  get '/dashboard/profile/:id/edit' => 'users#edit', :as => 'profile_edit'
  get '/dashboard/profile/:id' => 'users#show', :as => 'profile'

  get '/dashboard/member_profile/:id' => 'users#member_show', :as => 'member_profile'

  resources :users, path: :profile, shallow: true, only: %i[show edit update]


  resources :users, path: :dashboard, shallow: true, only: %i[show] do
    resources :teams, shallow: true
  end


  delete '/teams/:id' => 'teams#destroy', :as => 'admin_team_delete'

  resources :team, only: %i[show] do
    resources :projects, shallow: true, except: %i[index]
    resources :members, path: :myteam
  end

  resources :projects, only: %i[show] do
    resources :tasks
  end

  get '/dashboard/:id/index/teams' => 'public_teams#index', :as => 'index_teams'
  get '/dashboard/:id/index/projects' => 'public_teams#show', :as => 'index_projects'

  delete '/logout' => 'sessions#destroy', :as => 'logout'


  # index
  # new
  # create
  # show
  # edit
  # update
  # destroy
end
