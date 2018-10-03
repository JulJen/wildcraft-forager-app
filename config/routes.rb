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

  get '/dashboard/categories' => 'categories#index', :as => 'categories'
  get '/categories/:id' => 'categories#show', :as => 'categories_teams'


  delete '/logout' => 'sessions#destroy', :as => 'logout'

  get '/dashboard/profile/:id/edit' => 'users#edit', :as => 'edit_profile'
  get '/dashboard/profile/:id' => 'users#show', :as => 'profile'

  get '/dashboard/member_profile/:id' => 'users#member_show', :as => 'member_profile'

  resources :users, path: :profile, shallow: true, only: %i[show edit update]

  namespace :admin do
    resources :projects
    # , except: %i[index show]
  end

  # namespace :admin do
  #   resources :posts
  #   # , except: %i[show]
  # end

  # scope module: 'admin', path: 'admin', as: 'admin' do
  #   resources :projects
  #   # , except: %i[show]
  # end

  resources :projects, only: %i[index show] do
    resources :posts
    # , except: %i[index show]
  end



  # resources :projects, only: %i[index show] do
  #     resources :posts, only: %i[index show]
  # end




  # index
  # new
  # create
  # show
  # edit
  # update
  # destroy
end
