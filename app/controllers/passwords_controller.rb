class PasswordsController < ApplicationController

  before_filter :find_player

  def edit
  end

  def update
    if @player.change_password(params[:player])
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

end
