class GamesController < ApplicationController

  #before_filter :login_required
  before_filter :setup_title
  
  layout "no_sidebar"
  
  active_tab :tracker

  def index
  end

  def new
    @game = Game.new
    @game.game_players.build
  end

  def create
    @game = Game.new(params[:game])
    @game.creator_id = current_player.id
    if @game.save
      redirect_to game_path(@game), notice: "Created new game!"
    else
      flash.now.alert = "There was an error creating your game"
      render action: :new
    end
  end

  def show
    @game = Game.find(params[:id])
    @turn = @game.turns.build
  end

  private

  def setup_title
    @page_title = "Game Tracker"
  end

end
