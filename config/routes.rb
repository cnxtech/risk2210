Risk2210::Application.routes.draw do
  
  ## Sessions
  get '/login' => 'sessions#new', as: :login
  post '/login' => 'sessions#create', as: :create_session  
  match '/logout' => 'sessions#destroy', as: :logout
  
  ## Facebook Sessions
  match '/login/facebook' => redirect('/auth/facebook'), as: :facebook_authentication
  match '/auth/:provider/callback' => 'sessions#authenticate_facebook'
  match '/auth/failure' => 'sessions#failure'
  
  resources :factions, only: [:index, :show]
  resources :players
  
  resources :forums, only: [:index, :show] do
    resources :topics do
      post :create_comment, on: :member
    end
  end
  
  root to: 'home#index'

end
