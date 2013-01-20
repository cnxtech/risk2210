module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :current_player
  end

  def current_player
    begin
      if session[:player_id]
        @current_player ||= Player.find(session[:player_id])
      elsif cookies.signed[:remember_me_token].present?
        @current_player ||= Player.where(remember_me_token: cookies.signed[:remember_me_token]).first
        session[:player_id] = @current_player.id
      end
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
    cookies.delete(:remember_me_token)
    reset_session
  end

  def login(player, options={})
    path = options.fetch(:redirect_to, new_game_path)
    notice = options.fetch(:notice, "Welcome Back!")
    remember_me = options.fetch(:remember_me, "0").to_boolean

    cookies.signed[:remember_me_token] = {value: player.remember_me_token, expires: 1.month.from_now} if remember_me

    session[:player_id] = player.id
    redirect_back_or_default(path, notice: notice)
  end

end
