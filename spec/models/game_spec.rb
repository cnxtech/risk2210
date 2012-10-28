require 'spec_helper'

describe Game do
  
  before do
    load("#{Rails.root}/db/factions.rb")
    load("#{Rails.root}/db/maps.rb")

    @game_player_attributes = {}
    2.times do |index|
      player = FactoryGirl.create(:player)
      @game_player_attributes[index.to_s] = {player_id: player.id, faction_id: faction_ids[index], color: GamePlayer::COLORS.sample}
    end
  end

  let(:map_ids) { Map.all.sample(3).map(&:id) }
  let(:faction_ids) { Faction.all.sample(2).map(&:id) }
  let(:game) { FactoryGirl.create(:game, map_ids: map_ids[0..1], game_players_attributes: @game_player_attributes) }

  describe "has_map?" do
    it "should return true if a game has a map" do

      game.has_map?(Map.find(map_ids[0])).should == true
      game.has_map?(Map.find(map_ids[1])).should == true
      game.has_map?(Map.find(map_ids[2])).should == false
    end
  end

  describe "map_names" do
    it "should join the map names" do
      game.map_names.should == "#{game.maps[0].name} and #{game.maps[1].name}"
    end
  end

  describe "percent_complete" do
    it "should description" do
      pending
    end
  end

  describe "turn_count" do
    it "should description" do
      pending
    end
  end

  describe "validations" do
    it "should be invalid with less than 2 players" do
      pending
    end
    it "should be invalid without any maps" do
      pending
    end
  end

end
