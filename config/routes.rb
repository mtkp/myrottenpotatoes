Myrottenpotatoes::Application.routes.draw do
  
  # movie routes
  resources :movies do
    resources :reviews
  end
  post '/movies/search_tmdb'

  # root
  root to: redirect('/movies')

  # omniauth & sessions routes
  get 'auth/twitter', as: 'login'
  get 'auth/twitter/callback' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
end
