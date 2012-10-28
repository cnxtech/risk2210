require 'spec_helper'

describe Game do
  
  before do
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
    it "should return the percentage of the game that has been completed" do
      3.times do
        FactoryGirl.create(:turn, game: game, game_player: game.game_players.first)
        FactoryGirl.create(:turn, game: game, game_player: game.game_players.second)
      end

      game.percent_complete.should == 60.0
    end
  end

  describe "turn_count" do
    it "should return the total number of turns the game has" do
      3.times do
        FactoryGirl.create(:turn, game: game, game_player: game.game_players.first)
        FactoryGirl.create(:turn, game: game, game_player: game.game_players.second)
      end

      game.turn_count.should == 6
    end
  end

  describe "validations" do
    it "should be invalid with less than 2 players" do
      @game_player_attributes.delete("0")
      game = FactoryGirl.build(:game, map_ids: map_ids[0..1], game_players_attributes: @game_player_attributes)

      game.valid?.should == false
      game.errors[:base].include?("You must have at least two players.").should == true
    end
    it "should be invalid without any maps" do
      game = FactoryGirl.build(:game, map_ids: [], game_players_attributes: @game_player_attributes)

      game.valid?.should == false
      game.errors[:base].include?("You must choose one or more maps to play.").should == true
    end
  end

end
