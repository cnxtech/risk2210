require 'spec_helper'

describe GamePlayer do

  describe "set_starting_units" do
    it "should set the default starting units and energy for the faction" do
      random_faction = Faction.random

      game_player = FactoryGirl.build(:game_player, faction_id: random_faction.id, starting_territory_count: 12)
      game_player.save

      game_player.starting_territory_count.should == 12
      game_player.territory_count.should == 12
      game_player.energy = random_faction.min_energy
      game_player.units = random_faction.min_units
    end
  end

  describe "handle=" do
    it "should find the player and set the id based on the handle" do
      player = FactoryGirl.create(:player, handle: "Payton")

      game_player = FactoryGirl.create(:game_player, handle: "Payton", player: nil)

      game_player.player.should == player
    end
  end

  describe "profile_image_path" do
    it "should return the player's profile image if the player is present" do
      player = FactoryGirl.create(:player, facebook_image_url: "http://example.com", image_source: Player::ImageSource::Facebook)
      game_player = FactoryGirl.create(:game_player, player: player)

      game_player.profile_image_path.should == player.profile_image_path
    end
    it "should return the default profile image if there is no player" do
      game_player = FactoryGirl.create(:game_player, player: nil)

      game_player.profile_image_path.should == "http://risk2210.net/assets/default_avatar.png"
    end
  end

  describe "continent_bonus" do
    it "should return the sum of the continent bonuses" do
      continent1 = Continent.all.sample(1).first
      continent2 = Continent.all.sample(1).first
      game_player = FactoryGirl.build(:game_player)
      game_player.continent_ids = [continent1.id, continent2.id]

      game_player.continent_bonus.should == continent1.bonus + continent2.bonus
    end
  end

  describe "colony_influence_bonus" do
    it "should multiply the number of colony influence cards by 3" do
      game_player = FactoryGirl.build(:game_player, colony_influence: 3)

      game_player.colony_influence_bonus.should == 9
    end
  end

  describe "final_score" do
    it "should calculate the player's final score" do
      continent1 = Continent.all.sample(1).first
      continent2 = Continent.all.sample(1).first
      game_player = FactoryGirl.build(:game_player, colony_influence: 2, territory_count: 30)
      game_player.continent_ids = [continent1.id, continent2.id]

      game_player.final_score.should == 30 + continent1.bonus + continent2.bonus + (2 * 3)
    end
  end

  describe "starting_space_stations" do
    it "return the starting space station count of the game_player's faction" do
      faction = Faction.random
      game_player = FactoryGirl.build(:game_player, faction: faction)

      game_player.starting_space_stations.should == faction.space_stations
    end
  end

  describe "hex_color" do
    it "should return the hex color for the color passed in" do
      GamePlayer::COLORS.each do |color|
        GamePlayer.hex_color(color).blank?.should == false
      end
    end
  end

end
