Risk2210::Application.routes.draw do
  
  ## Sessions
  match '/auth/:provider/callback' => 'sessions#create_facebook'
  match '/auth/failure' => 'sessions#failure'
  get '/login' => 'sessions#new', as: :login
  post '/login' => 'sessions#create', as: :create_session
  match '/login/facebook' => redirect('/auth/facebook'), as: :facebook_authorization
  match '/logout' => 'sessions#destroy', as: :logout
  
  resources :factions, only: [:index, :show]
  resources :players, except: [:destroy]
  
  resources :forums, only: [:index, :show] do
    resources :topics do
      post :create_comment, on: :member
    end
  end
  
  root to: 'home#index'

end
