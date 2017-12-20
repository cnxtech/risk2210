require 'rails_helper'

describe GamePlayerStat do

  let(:continents) { Continent.all.sample(4) }

  describe "cache_game_player_stats" do
    it "should update the current statistics on the game player model" do
      continent_ids = continents.map(&:id)
      game = create(:game)
      game_player = game.game_players.first

      turn = create(:turn, game: game, game_player: game_player, game_player_stats_attributes: [{game_player_id: game_player.id, energy: 14, units: 14, territory_count: 25, continent_ids: continent_ids}])

      game_player.reload
      expect(game_player.energy).to eq(14)
      expect(game_player.units).to eq(14)
      expect(game_player.territory_count).to eq(25)
      expect(game_player.continent_ids).to eq(turn.game_player_stats.first.continent_ids)
    end
  end

  describe "continent_bonus" do
    it "should return the sum of the player's continent bonus" do
      game_player_stat = create(:game_player_stat, continent_ids: continents.map(&:id))

      expect(game_player_stat.continent_bonus).to eq(continents.sum(&:bonus).to_i)
    end
  end

end
