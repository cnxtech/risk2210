class SessionsController < ApplicationController

  def create
    #raise request.env["omniauth.auth"].to_yaml
    
    auth = request.env["omniauth.auth"]
    #player = Player.where(:provider => auth['provider'], :uid => auth['uid']).first || Player.create_with_omniauth(auth)
    player = Player.omniauthorize(auth)
    
    session[:player_id] = player.id
    redirect_to root_url, :notice => "Signed in!"
  end
  
  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end
  
  def new
    redirect_to '/auth/facebook'
  end
  
  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end
  
end