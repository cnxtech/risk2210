class ApplicationController < ActionController::Base
  include Authentication
  
  layout "railscast"
  
  protect_from_forgery

end
