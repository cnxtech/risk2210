require 'spec_helper'

describe Turn do
  
  describe "update_game_player_stats" do
    it "should update the current statistics on the game player model" do
      ## Setup boards
      earth = FactoryGirl.create(:map, name: "Earth")
      moon = FactoryGirl.create(:map, name: "Moon", moon: true)
      5.times { FactoryGirl.create(:continent, map: earth) }
      3.times { FactoryGirl.create(:continent, map: moon) }
      continent_ids = Continent.all.map(&:id)

      ## Setup players
      player1 = FactoryGirl.create(:player)
      player2 = FactoryGirl.create(:player)
      faction1 = FactoryGirl.create(:faction)
      faction2 = FactoryGirl.create(:faction)

      ## Setup game
      game_players = {}
      game_players["0"] = {color: "Blue", player_id: player1.id, faction_id: faction1.id}
      game_players["1"] = {color: "Green", player_id: player2.id, faction_id: faction2.id}
      game = FactoryGirl.create(:game, map_ids: [earth.id, moon.id], game_players_attributes: game_players)
      game_player = game.game_players.first

      turn = FactoryGirl.create(:turn, game_player: game_player, energy_collected: 14, units_collected: 14, territories_held: 25, continent_ids: continent_ids.sample(4))

      game_player.energy.should == 14
      game_player.units.should == 14
      game_player.territory_count.should == 25
      game_player.continent_ids.should == turn.continent_ids
    end
  end

end
