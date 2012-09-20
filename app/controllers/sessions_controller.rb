class SessionsController < ApplicationController

  def authenticate_facebook
    auth = request.env["omniauth.auth"]
    player = Player.omniauthorize(auth)
    login(player)
  end
  
  def destroy
    logout
    redirect_to root_path, notice: 'Signed out!'
  end

  def new
    @page_title = "Login"
    @session = Session.new
  end
  
  def create
    @page_title = "Login"
    @session = Session.new(params[:session])
    if @session.authenticated?
      login(@session.player, remember_me: params[:session][:remember_me])
    else
      flash.now.alert = "We are sorry, but either your email or password is invalid."
      render action: :new
    end
  end
  
  def failure
    redirect_to root_path, alert: "Facebook authentication error: #{params[:message].humanize}"
  end
  
end