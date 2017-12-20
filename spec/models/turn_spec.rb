require 'rails_helper'

describe Turn do

  let(:game) { build(:game) }
  let(:next_player) { build(:game_player, turn_order: 3) }

  describe "set_current_player" do
    it "should update the current_player on the game to be the player with the next turn_order" do
      game.game_players << next_player
      game.save

      create(:turn, game: game, game_player: game.game_players.second, order: 2)

      expect(game.current_player).to eq(next_player)
    end
  end

end
