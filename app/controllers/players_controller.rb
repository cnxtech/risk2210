class PlayersController < ApplicationController

  before_action :login_required, only: [:edit, :update, :destroy]
  before_action :find_player, only: [:show, :edit, :update, :destroy]
  before_action :authorize_current_player, only: [:edit, :update, :destroy]

  active_tab :players

  def index
    @players = Player.public_profiles
  end

  def show
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      login(@player, redirect_to: edit_player_path(@player), notice: "Thanks for registering! Please fill out your profile.")
    else
      flash.now.alert = "There was an error creating your account."
      render action: :new
    end
  end

  def edit
  end

  def update
    if @player.update_attributes(player_params)
      redirect_to player_path(@player), notice: "Thanks for updating your profile!"
    else
      flash.now.alert = "There was an error updating your profile."
      render action: :edit
    end
  end

  def destroy
    @player.destroy
    logout
    redirect_to root_path, notice: "Your account has been removed. Sorry to see you go. :("
  end

private

  def find_player
    @player = Player.find(params[:id])
    raise Mongoid::Errors::DocumentNotFound.new(Player, params[:id], params[:id]) if @player.nil?
  end

  def authorize_current_player
    if current_player != @player
      redirect_to root_path, alert: "Unauthorized!"
    end
  end

  def player_params
    params.require(:player).permit(:email, :first_name, :last_name, :handle, :city, :state, :zip_code, :bio, :website, :image_source, :public_profile, :password, :password_confirmation, :old_password, :favorite_color)
  end

end
