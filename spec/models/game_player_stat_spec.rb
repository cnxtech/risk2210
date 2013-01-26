require 'spec_helper'

describe GamePlayerStat do

  describe "cache_game_player_stats" do
    it "should update the current statistics on the game player model" do
      continent_ids = Continent.all.map(&:id).sample(4)
      game = FactoryGirl.create(:game)
      game_player = game.game_players.first

      turn = FactoryGirl.create(:turn, game: game, game_player: game_player, game_player_stats_attributes: [{game_player_id: game_player.id, energy: 14, units: 14, territory_count: 25, continent_ids: continent_ids}])

      game_player.reload
      game_player.energy.should == 14
      game_player.units.should == 14
      game_player.territory_count.should == 25
      game_player.continent_ids.should == turn.game_player_stats.first.continent_ids
    end
  end

end
