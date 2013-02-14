class TurnsController < ApplicationController

  respond_to :json

  before_filter :login_required
  before_filter :find_game
  before_filter :validate_owner

  def create
    turn = @game.turns.build(turn_params)

    if turn.save
      render json: turn, root: false, status: :created
    else
      render json: turn.errors, status: :not_acceptable
    end
  end

  def start_year
    if @game.start_year(params[:turn_order])
      render json: @game, root: false, status: :ok
    else
      render json: @game.errors, status: :not_acceptable
    end
  end

  def end_game
    @game.end_game(params[:colony_influence])
    head :ok
  end

  private

  def find_game
    @game = Game.find(params[:game_id])
  end

  def validate_owner
    if @game.creator != current_player
      head :unauthorized
    end
  end

  def turn_params
    params.permit(:order, :year, :game_player_id, game_player_stats_attributes: [:game_player_id, :energy, :units, :continent_ids, :territory_count])
  end

end
