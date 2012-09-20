class PlayersController < ApplicationController
  
  respond_to :html, :json
  
  before_filter :login_required, only: [:edit, :update, :destroy]
  before_filter :find_player, only: [:show, :edit, :update, :destroy]
  before_filter :authorize_current_player, only: [:edit, :update, :destroy]

  active_tab :players
  
  def index
    @page_title = "Players"
    @players = Player.public_profiles

    respond_with(@players)
  end
  
  def show
    @page_title = "#{@player.handle} | Players"
    respond_with(@player)
  end
  
  def new
    @page_title = "New Player"
    @player = Player.new
  end
  
  def create
    @player = Player.new(params[:player])
    if @player.save
      login(@player, redirect_to: edit_player_path(@player), notice: "Thanks for registering! Please fill out your profile.")
    else
      @page_title = "New Player"
      flash.now.alert = "There was an error creating your account."
      render action: :new
    end
  end
  
  def edit
    @page_title = "Edit Profile"
  end
  
  def update
    if @player.update_attributes(params[:player])
      respond_to do |format|
        format.html { redirect_to player_path(@player), notice: "Thanks for updating your profile!" }
        format.json { render nothing: true }
      end
    else
      @page_title = "Edit Profile"
      respond_to do |format|
        format.html { 
          flash.now.alert = "There was an error updating your profile."
          render action: :edit
        }
        format.json { render json: @player.errors.full_messages, status: 400 }
      end
    end
  end
  
  def destroy
    @player.destroy
    logout
    redirect_to root_path, notice: "Your account has been removed. Sorry to see you go."
  end
  
  private
  
  def find_player
    @player = Player.find(params[:id])
  end
  
  def authorize_current_player
    if current_player != @player
      redirect_to root_path, alert: "You aren't authorized to edit that player!"
    end
  end
  
end
