Myrottenpotatoes::Application.routes.draw do
  # movie routes
  resources :movies do
    resources :reviews, except: [:index, :show]
  end
  post '/movies/search_tmdb'
  post '/movies/add_from_tmdb'

  # root
  root to: redirect('/movies')

  # omniauth & sessions routes
  get 'login' => 'sessions#new'
  get 'auth/twitter', as: 'twitter_auth'
  get 'auth/facebook', as: 'facebook_auth'
  get 'auth/twitter/callback' => 'sessions#create'
  get 'auth/facebook/callback' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
end
