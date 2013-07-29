Myrottenpotatoes::Application.routes.draw do
  resources :movies
  post '/movies/search_tmdb'
  root to: redirect('/movies')
  get 'auth/twitter', as: 'login'
  get 'auth/twitter/callback' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
end
