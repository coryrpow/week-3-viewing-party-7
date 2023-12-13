Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', to: 'users#new'
  get '/logtout', to: 'users#logout', as: 'logout'
  post '/users', to: 'users#create'
  get '/movies', to: 'movies#index', as: 'movies'
  get '/movies/:id', to: 'movies#show', as: 'movie'

  resources :users, only: :show

  get '/movies/:movie_id/viewing_parties/new', to: 'viewing_parties#new'
  post '/movies/:movie_id/viewing_parties', to: 'viewing_parties#create'

  get '/login', to: 'users#login_form', as: 'login_form'
  post '/login', to: 'users#login', as: 'login'
end
