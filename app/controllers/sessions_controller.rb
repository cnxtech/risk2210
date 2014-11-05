class SessionsController < ApplicationController

  def authenticate_facebook
    player = Authentication::Facebook.new(request.env["omniauth.auth"]).authenticate
    login(player)
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Signed out!'
  end

  def new
    @session = Authentication::Risk2210.new
  end

  def create
    @session = Authentication::Risk2210.new(params[:session])
    if player = @session.authenticate
      login(player, remember_me: params[:session][:remember_me])
    else
      flash.now.alert = "We are sorry, but either your email or password is invalid."
      render action: :new
    end
  end

  def failure
    redirect_to root_path, alert: "Facebook authentication error: #{params[:message].humanize}"
  end

end
