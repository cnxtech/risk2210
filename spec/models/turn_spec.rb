require 'spec_helper'

describe Turn do

  describe "update_game_player_stats" do
    it "should update the current statistics on the game player model" do
      ## Setup boards
      continent_ids = Continent.all.map(&:id).sample(4)
      faction_ids = Faction.all.map(&:id).sample(2)
      map_ids = Map.all.map(&:id).sample(2)

      ## Setup players
      player1 = FactoryGirl.create(:player)
      player2 = FactoryGirl.create(:player)

      ## Setup game
      game_players = {}
      game_players["0"] = {color: "Blue", handle: player1.handle, faction_id: faction_ids[0]}
      game_players["1"] = {color: "Green", handle: player2.handle, faction_id: faction_ids[1]}
      game = FactoryGirl.create(:game, map_ids: map_ids, game_players_attributes: game_players)
      game_player = game.game_players.first

      turn = FactoryGirl.create(:turn, game_player: game_player, energy_collected: 14, units_collected: 14, territories_held: 25, continent_ids: continent_ids)

      game_player.energy.should == 14
      game_player.units.should == 14
      game_player.territory_count.should == 25
      game_player.continent_ids.should == turn.continent_ids
    end
  end

end
