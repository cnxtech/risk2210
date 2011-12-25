class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    player = Player.omniauthorize(auth)
    login(player)
    redirect_to root_path, notice: "Signed in!"
  end
  
  def destroy
    logout
    redirect_to root_path, notice: 'Signed out!'
  end
  
  def new
    redirect_to '/auth/facebook'
  end
  
  def failure
    redirect_to root_path, alert: "Authentication error: #{params[:message].humanize}"
  end
  
end