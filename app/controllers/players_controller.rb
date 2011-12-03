class PlayersController < ApplicationController
  
  respond_to :html, :xml, :json
  
  before_filter :login_required, :only => [:edit, :update, :destroy]
  before_filter :find_player, :only => [:show, :edit, :update, :destroy]
  before_filter :authorize_current_player, :only => [:edit, :update, :destroy]
  
  def index
    @players = Player.all
    respond_to do |format|
      format.json {render :json => {:players => @players,  :callback => params["_dc"]}}
      format.html{}
    end
  end
  
  def show
    respond_with(@player)
  end
  
  # def new
  #   @player = Player.new
  # end
  # 
  # def create
  #   @player = Player.new(params[:player])
  #   if @player.save
  #     login(@player)
  #     redirect_to player_path(@player), :notice => "Thanks for registering!"
  #   else
  #     flash.now.alert = "There was an error with your account."
  #     render :action => :new
  #   end
  # end
  
  def edit
  end
  
  def update
    if @player.update_attributes(params[:player])
      redirect_to player_path(@player), :notice => "Thanks for updating your profile!"
    else
      flash.now.alert = "There was an error with your profile."
      render :action => :edit
    end
  end
  
  def destroy
    @player.destroy
    logout
    redirect_to root_path, :notice => "Successfully removed your account."
  end
  
  private
  
  def find_player
    @player = Player.find(params[:id])
  end
  
  def authorize_current_player
    if current_player != @player
      redirect_to root_path, :alert => "You aren't authorized to edit that player!"
    end
  end
  
end
