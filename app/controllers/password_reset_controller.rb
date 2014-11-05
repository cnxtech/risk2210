class PasswordResetController < ApplicationController

  def index
  end

  def create
    @player = Player.where(email: params[:player][:email]).first
    if @player
      @player.request_password_reset!
      redirect_to root_path, notice: "Please check your email for instructions on how to reset your password."
    else
      redirect_to forgot_password_path, alert: "Sorry, no player was found with the email: #{params[:player][:email]}"
    end
  end

  def show
    @player = Player.where(password_reset_token: params[:token]).first
    if @player.nil?
      redirect_to root_path, alert: "Sorry, no player was found with the token used."
    end
  end

  def update
    @player = Player.where(password_reset_token: params[:token]).first
    if @player.change_password(player_params, validate_old_password: false)
      @player.update_attribute(:password_reset_token, nil)
      login(@player, notice: "Password successfully reset!", redirect_to: edit_player_path(@player))
    else
      redirect_to find_password_reset_path(params[:token]), alert: "Your password and confirmation don't match"
    end
  end

private

  def player_params
    params.require(:player).permit(:password, :password_confirmation)
  end

end
