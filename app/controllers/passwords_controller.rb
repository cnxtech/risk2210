class PasswordsController < ApplicationController

  before_filter :login_required
  before_filter :find_player
  before_filter :setup_title

  def edit
  end

  def update
    if @player.change_password(player_params)
      redirect_to player_path(current_player), notice: "Successfully changed your password."
    else
      flash.now.alert = "There was an error changing your password."
      render action: :edit
    end
  end

private

  def find_player
    @player = current_player
  end

  def setup_title
    @page_title = "Change Password"
  end

  def player_params
    params.require(:player).permit(:password, :password_confirmation, :old_password)
  end

end
