Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/auth/google_oauth2/callback', to: 'users#create'
  get '/auth/google_oauth2/callback', to: 'sessions#create'

  root 'application#welcome'
  # get '/success', to: 'application#success'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/profile' => 'users#index'
  get '/dashboard' => 'users#show'

  get '/your_teams' => 'teams#index'
  get '/new_team' => 'teams#new'
  post '/new_team' => 'teams#create'

  get '/team_projects' => 'projects#index'

  delete '/logout' => 'sessions#destroy'

  # scope '/admin', shallow: true do
  #   resources :teams, only: %i[show edit update destroy]
  # end
  #
  # scope '/admin', shallow: true do
  #   resources :projects, only: %i[show edit update destroy]
  # end


  resources :users, only: '/dashboard', shallow: true do
    resources :teams, except: %i[index]
  end

  # resources :teams, except: %i[index new edit update destroy]

  # resources :projects, except: %i[index new edit update destroy]

  # Teams has_many Projects, Projects have_many Users
  resources :teams, only: '/your_teams', shallow: true do
    resources :projects, except: %i[index]
  end

end
