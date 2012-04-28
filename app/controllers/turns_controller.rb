class TurnsController < ApplicationController

  respond_to :json

  before_filter :login_required
  before_filter :find_game
  before_filter :validate_owner

  def create
    @turn = @game.turns.build(game_player_id: params[:game_player_id],
                              energy_collected: params[:energy_collected], 
                              units_collected: params[:units_collected], 
                              territories_held: params[:territories_held], 
                              continent_ids: params[:continent_ids])
    @turn.save

    render json: @turn
  end

  private

  def find_game
    @game = Game.find(params[:game_id])
  end

  def validate_owner
    if @game.creator != current_player
      render nothing: true, status: 422
    end
  end

end
