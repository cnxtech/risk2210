class GamesController < ApplicationController

  before_filter :login_required, only: [:new, :create, :destroy]
  before_filter :setup_title

  layout "no_sidebar"

  active_tab :tracker

  def new
    @game = Game.new(location: current_player.location)
    @game.game_players.build(handle: current_player.handle, color: current_player.favorite_color)
    @game.game_players.build
  end

  def create
    @game = current_player.games.build(game_params)
    if @game.save
      redirect_to game_path(@game), notice: "Created new game!"
    else
      flash.now.alert = "There was an error creating your game"
      render action: :new
    end
  end

  def show
    @game = Game.find(params[:id])
    raise Mongoid::Errors::DocumentNotFound.new(Game, params[:id], params[:id]) if @game.nil?
  end

  def destroy
    @game = Game.find(params[:id])
    if current_player != @game.creator
      redirect_to root_path, alert: "Sorry, you can't delete a game you didn't create!"
    else
      @game.destroy
      redirect_to root_path, notice: "Successfully removed game."
    end
  end

  def results
    @game = Game.find(params[:id])
  end

private

  def setup_title
    @page_title = "Game Tracker"
  end

  def game_params
    params.require(:game).permit(:location, :notes, {map_ids: []}, :game_players_attributes, :number_of_years, game_players_attributes: [:color, :starting_territory_count, :energy, :units, :faction_id, :handle, :continent_ids, :map_ids, :turn_order])
  end

end
