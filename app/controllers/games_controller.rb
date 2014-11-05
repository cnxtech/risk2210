class GamesController < ApplicationController

  before_filter :login_required, only: [:new, :create, :destroy]
  before_filter :find_game, only: [:show, :update, :destroy, :results]
  before_filter :validate_creator, only: [:update, :destroy]

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
    raise Mongoid::Errors::DocumentNotFound.new(Game, params[:id], params[:id]) if @game.nil?
  end

  def destroy
    @game.destroy
    redirect_to root_path, notice: "Successfully removed game."
  end

  def results
    unless @game.completed?
      redirect_to game_path(@game) and return
    end

    @chart_data_formatter = ChartDataFormatter.new(@game)
  end

  def update
    if @game.save_event(params[:event], params[:payload])
      render json: @game, root: false, status: :ok
    else
      render json: @game.errors, status: :not_acceptable
    end
  end

private

  def game_params
    params.require(:game).permit(:location, :notes, {map_ids: []}, :number_of_years, game_players_attributes: [:color, :starting_territory_count, :energy, :units, :faction_id, :handle, :continent_ids, :map_ids, :turn_order])
  end

  def find_game
    @game = Game.find(params[:id])
  end

  def validate_creator
    if current_player != @game.creator
      redirect_to root_path, alert: "Sorry, you aren't authorized to modify this game."
    end
  end

end
