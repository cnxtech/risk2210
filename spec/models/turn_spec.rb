require 'spec_helper'

describe Turn do

  describe "set_current_player" do
    it "should update the current_player on the game to be the player with the next turn_order" do
      game = FactoryGirl.build(:game)
      next_player = FactoryGirl.build(:game_player, turn_order: 3)
      game.game_players << next_player
      game.save

      FactoryGirl.create(:turn, game: game, game_player: game.game_players.second, order: 2)
      game.reload

      game.current_player.should == next_player
    end
  end

end
