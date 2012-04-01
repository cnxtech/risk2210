module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :current_player
  end
    
  def current_player
    begin
      @current_player ||= Player.find(session[:player_id]) if session[:player_id]
    rescue Mongoid::Errors::DocumentNotFound
      nil
    end
  end

  def login_required
    if current_player.nil?
      session[:return_to_path] = request.url
      redirect_to login_path, alert: "You need to be logged in!"
    end
  end

  def redirect_back_or_default(default=:back, flash={})
    if session[:return_to_path].present?
      return_to_path = session[:return_to_path]
      session[:return_to_path] = nil
      redirect_to return_to_path, flash
    else
      redirect_to default, flash
    end
  end

  def logout
    reset_session
  end

  def login(player)
    session[:player_id] = player.id
    redirect_back_or_default(:back, notice: "Welcome Back!")
  end
  
end
