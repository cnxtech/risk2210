class GamesController < ApplicationController

  before_filter :login_required

  active_tab :tracker

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
    @turns = @game.turns.all
    @turn = @game.turns.build
  end

end
