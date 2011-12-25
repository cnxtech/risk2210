Risk2210::Application.routes.draw do
  
  ## Omniauth Sessions
  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/failure' => 'sessions#failure'
  match '/login' => 'sessions#new', as: :login
  match '/logout' => 'sessions#destroy', as: :logout
  
  resources :factions, only: [:index, :show]
  resources :players, only: [:index, :show, :edit, :update, :destroy]
  
  resources :forums, only: [:index, :show] do
    resources :topics do
      post :create_comment, on: :member
    end
  end
  
  root to: 'home#index'

end
