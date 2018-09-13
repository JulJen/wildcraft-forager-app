Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  match '/auth/google_oauth2/callback', to: 'sessions#create', via: [:get, :post]

  # get '/auth/google_oauth2/callback', to: 'sessions#create'

  root 'application#welcome', :as => 'welcome'

  get '/projectmanageable' => 'application#enter', :as => 'enter'

  get '/projectmanageable/signin' => 'sessions#new', :as => 'signin'
  post '/signin' => 'sessions#create'

  get '/projectmanageable//signup' => 'users#new', :as => 'signup'
  post '/signup' => 'users#create'

  # match '/signup', to: 'users#create',  via: [:get, :post]

  get '/profile' => 'users#index', :as => 'profile'
  get '/dashboard' => 'users#show', :as => 'dashboard'

  delete '/teams/:id/delete_team' => 'teams#destroy', :as => 'delete_team'
  delete '/teams/:id/projects/:id/delete_project' => 'projects#destroy', :as => 'delete_project'


  delete '/logout' => 'sessions#destroy', :as => 'logout'




  # resources :users, only: %i[new create]

  resources :users, only: %i[dashboard] do
    resources :teams, except: %i[delete], shallow: true
    resources :projects, except: %i[new create delete], shallow: true
  end

  # resources :users, only: %i[dashboard] do
  #   resources :teams, shallow: true
  # end
  # #
  # # resources :users, only: %i[dashboard] do
  # #   resources :projects, shallow: true
  # # end
  resources :teams, only: %i[show] do
    resources :projects, only: %i[index new create], shallow: true
  end

end
