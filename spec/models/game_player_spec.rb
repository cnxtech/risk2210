require 'spec_helper'

describe GamePlayer do

  describe "set_starting_units" do
    it "should set the default starting units and energy for the faction" do
      random_faction = Faction.random

      game_player = FactoryGirl.build(:game_player, faction_id: random_faction.id, territory_count: nil)
      game_player.save

      game_player.territory_count.should == 0
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

end
