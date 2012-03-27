Risk2210::Application.routes.draw do
  
  ## Sessions
  get '/login' => 'sessions#new', as: :login
  post '/login' => 'sessions#create', as: :create_session  
  delete '/logout' => 'sessions#destroy', as: :logout
  
  ## Facebook Sessions
  get '/login/facebook' => redirect('/auth/facebook'), as: :facebook_authentication
  match '/auth/:provider/callback' => 'sessions#authenticate_facebook'
  match '/auth/failure' => 'sessions#failure'

  ## Change Password
  get "/account/password" => "passwords#edit", as: :edit_password
  put "/account/password" => "passwords#update", as: :update_password
  
  resources :factions, only: [:index, :show]
  resources :players
  
  ## Game Tracker
  resources :games
  
  ## Forums
  resources :forums, only: [:index, :show] do
    resources :topics, only: [:show, :create] do
      post :create_comment, on: :member
    end
  end
  
  root to: 'home#index'

end
