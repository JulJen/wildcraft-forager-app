Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/404', :to => 'application#not_found'
  get '/422', :to => 'application#unacceptable'
  get '/500', :to => 'application#internal_error'

  get '/auth/google_oauth2/callback', to: 'sessions#create'

  root 'application#welcome', :as => 'welcome'
  get '/wildcraft_forager' => 'application#enter', :as => 'enter'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/dashboard' => 'users#index', :as => 'main'


  get '/dashboard/categories' => 'categories#index', :as => 'categories'
  get '/categories/:id' => 'categories#show', :as => 'categories_teams'


  delete '/logout' => 'sessions#destroy', :as => 'logout'

  get '/dashboard/profile/:id/edit' => 'users#edit', :as => 'edit_profile'
  get '/dashboard/profile/:id' => 'users#show', :as => 'profile'

  resources :users, path: :profile, shallow: true, only: %i[show edit update]


  get '/members/:id' => 'users#show_member', :as => 'show_member'



  resources :topics do
    resources :posts
  end


  get '/topics/:id/members' => 'users#member_new', :as => 'new_project_member'
  post '/topics/:id/members/:id' => 'users#member_create'

  get '/members/:id/profile' => 'users#member_show', :as => 'member_profile'


  get '/topics/:id/members' => 'topics#new_member', :as => 'new_member'
  post '/topics/:id/members' => 'topics#create'

end
