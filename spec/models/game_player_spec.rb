require 'spec_helper'

describe GamePlayer do
  
  describe "set_starting_units" do
    it "should set the default starting units and energy for the faction" do
      load_factions
      random_faction = Faction.random

      game_player = FactoryGirl.build(:game_player, faction_id: random_faction.id, territory_count: nil)
      game_player.save

      game_player.territory_count.should == 0
      game_player.energy = random_faction.min_energy
      game_player.units = random_faction.min_units
    end
  end

end
