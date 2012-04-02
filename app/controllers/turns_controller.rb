class TurnsController < ApplicationController

  before_filter :login_required
  before_filter :find_game

  active_tab :tracker

  def create
    @turn = @game.turns.build(params[:turn])
    if !@turn.save
      ## TODO -- handle erros
      #flash.now.error = "Invalid turn!"
      #render template: "games/show"
    end
  end

  private

  def find_game
    @game = Game.find(params[:game_id])
  end

end
