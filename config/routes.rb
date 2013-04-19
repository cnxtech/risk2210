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

  ## Players
  resources :players

  ## Game Tracker
  resources :games, only: [:new, :create, :show, :destroy] do
    get :results, on: :member
  end

  ## Forums
  resources :forums, only: [:index, :show] do
    resources :topics, only: [:show, :create] do
      resources :comments, only: [:create, :edit, :update]
    end
  end

  ## Forgot Password
  get "/forgot-password" => "password_reset#index", as: :forgot_password
  post "/forgot-password" => "password_reset#create", as: :request_password_reset
  get "/reset-password/:token" => "password_reset#show", as: :find_password_reset
  put "/reset-password/:token" => "password_reset#update", as: :reset_password

  ## Expansions
  namespace :expansions do
    get "/" => "base#index", as: :index
    resources :factions, only: [:index, :show]
    get "/mars" => "maps#mars", as: :mars
    get "/io" => "maps#io", as: :io
    get "/europa" => "maps#europa", as: :europa
    get "/asteroid-colonies" => "maps#asteroid_colonies", as: :asteroid_colonies
    get "/pluto" => "maps#pluto", as: :pluto
    get "/arctic" => "maps#arctic", as: :arctic
    get "/titan" => "maps#titan", as: :titan
    get "/tech-commander" => "commanders#tech", as: :tech_commander
    get "/resistance-commander" => "commanders#resistance", as: :resistance_commander
    get "/invasion-of-the-giant-amoebas" => "misc#amoebas", as: :amoebas
    get "/galactic-risk" => "misc#galactic", as: :galactic
  end

  ## Misc
  get "/about" => "pages#about", as: :about
  get "/resources" => "pages#resources", as: :resources
  get "/api-docs" => "pages#api_docs", as: :api_docs

  ## API Endpoints
  scope "api/v1" do
    get "/factions" => "expansions/factions#index"
    get "/factions/:id" => "expansions/factions#show"
    get "/players" => "players#index"
    get "/players/:id" => "players#show"
    post "/turns" => "turns#create"
    put "/games/:id/:event" => "games#update"
  end

  ## Root
  root to: 'pages#home'

end
