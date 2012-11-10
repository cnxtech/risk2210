class GamesController < ApplicationController

  before_filter :login_required, only: [:new, :create]
  before_filter :setup_title

  layout "no_sidebar"

  active_tab :tracker

  def new
    @game = Game.new(location: current_player.location)
    @game.game_players.build(player_id: current_player.id)
    @game.game_players.build
  end

  def create
    @game = Game.new(game_params)
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
  end

private

  def setup_title
    @page_title = "Game Tracker"
  end

  def game_params
    params.require(:game).permit(:location , :notes, :map_ids, :game_players_attributes, :number_of_years, game_players_attributes: [:color, :territory_count, :energy, :units, :faction_id, :player_id, :continent_ids, :map_ids])
  end

end
