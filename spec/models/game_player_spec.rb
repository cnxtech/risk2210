require 'rails_helper'

describe GamePlayer do

  describe "set_starting_units" do
    it "should set the default starting units and energy for the faction" do
      random_faction = Faction.random

      game_player = create(:game_player, faction_id: random_faction.id, starting_territory_count: 12)

      expect(game_player.starting_territory_count).to eq(12)
      expect(game_player.territory_count).to eq(12)
      expect(game_player.energy).to eq(random_faction.min_energy)
      expect(game_player.units).to eq(random_faction.min_units)
    end
  end

  describe "handle=" do
    it "should find the player and set the id based on the handle" do
      player = create(:player, handle: "Payton")

      game_player = create(:game_player, handle: "Payton", player: nil)

      expect(game_player.player).to eq(player)
    end
  end

  describe "profile_image_path" do
    it "should return the player's profile image if the player is present" do
      player = create(:player, facebook_image_url: "http://example.com", image_source: Player::ImageSource::Facebook)
      game_player = create(:game_player, player: player)

      expect(game_player.profile_image_path).to eq(player.profile_image_path)
    end
    it "should return the default profile image if there is no player" do
      game_player = create(:game_player, player: nil)

      expect(game_player.profile_image_path).to eq("http://risk2210.net/assets/default_avatar.png")
    end
  end

  describe "continent_bonus" do
    it "should return the sum of the continent bonuses" do
      continent1 = Continent.all.sample(1).first
      continent2 = Continent.all.sample(1).first
      game_player = FactoryGirl.build(:game_player)
      game_player.continent_ids = [continent1.id, continent2.id]

      expect(game_player.continent_bonus).to eq(continent1.bonus + continent2.bonus)
    end
  end

  describe "colony_influence_bonus" do
    it "should multiply the number of colony influence cards by 3" do
      game_player = FactoryGirl.build(:game_player, colony_influence: 3)

      expect(game_player.colony_influence_bonus).to eq(9)
    end
  end

  describe "final_score" do
    it "should calculate the player's final score" do
      continent1 = Continent.all.sample(1).first
      continent2 = Continent.all.sample(1).first
      game_player = FactoryGirl.build(:game_player, colony_influence: 2, territory_count: 30)
      game_player.continent_ids = [continent1.id, continent2.id]

      expect(game_player.final_score).to eq(30 + continent1.bonus + continent2.bonus + (2 * 3))
    end
  end

  describe "starting_space_stations" do
    it "return the starting space station count of the game_player's faction" do
      faction = Faction.random
      game_player = FactoryGirl.build(:game_player, faction: faction)

      expect(game_player.starting_space_stations).to eq(faction.space_stations)
    end
  end

  describe "hex_color" do
    it "should return the hex color for the color passed in" do
      GamePlayer::COLORS.each do |color|
        expect(GamePlayer.hex_color(color)).to_not be_blank
      end
    end
  end

end
