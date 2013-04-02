require 'spec_helper'

describe Game do

  let(:map_ids) { Map.all.sample(3).map(&:id) }
  let(:faction_ids) { Faction.all.sample(2).map(&:id) }
  let(:game) { FactoryGirl.create(:game, map_ids: map_ids[0..1]) }

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

    before do
      @game_player_attributes = {}
      2.times do |index|
        player = FactoryGirl.create(:player)
        @game_player_attributes[index.to_s] = {handle: player.handle, faction_id: faction_ids[index], color: GamePlayer::COLORS.sample, turn_order: index + 1}
      end
    end

    it "should be invalid with less than 2 players" do
      game = Game.new(map_ids: map_ids[0..1])

      game.valid?.should == false
      game.errors[:base].include?("You must have at least two players.").should == true
    end
    it "should be invalid with more than 5 players" do
      4.times do |index|
        player = FactoryGirl.create(:player)
        @game_player_attributes[(index + 2).to_s] = {handle: player.handle, faction_id: faction_ids[index], color: GamePlayer::COLORS.sample}
      end

      game = FactoryGirl.build(:game, map_ids: map_ids[0..1], game_players_attributes: @game_player_attributes)

      game.valid?.should == false
      game.errors[:base].include?("You can't have more than five players.").should == true
    end
    it "should be invalid without any maps" do
      game = FactoryGirl.build(:game, map_ids: [], game_players_attributes: @game_player_attributes)

      game.valid?.should == false
      game.errors[:base].include?("You must choose one or more maps to play.").should == true
    end
    it "should be invalid if all players don't have a unique starting turn order" do
      @game_player_attributes["1"][:turn_order] = 1
      game = FactoryGirl.build(:game, map_ids: map_ids[0..1], game_players_attributes: @game_player_attributes)

      game.valid?.should == false
      game.errors[:base].include?("Every player must have a unique starting turn order.").should == true
    end
  end

  describe "start_year" do
    let(:game) { FactoryGirl.create(:game, current_year: 1) }
    it "should increment the year and set each game_player's turn order" do
      turn_order = {game.game_players.first.id.to_s => "2", game.game_players.second.id.to_s => "1"}
      game.start_year(turn_order)

      game.current_year.should == 2
      game.current_player.should == game.game_players.second
      game.game_players.first.turn_order.should == 2
      game.game_players.second.turn_order.should == 1
    end
    it "should populate errors if the save fails" do
      turn_order = {game.game_players.first.id.to_s => "2", game.game_players.second.id.to_s => "2"}
      game.start_year(turn_order)

      game.errors[:base].include?("Every player must have a unique starting turn order.").should == true
    end
  end

  describe "end_game" do
    let(:game) { FactoryGirl.create(:game) }
    it "should update the player's colony influence and the game's completed flag" do
      colony_influence = {game.game_players.first.id.to_s => "1", game.game_players.second.id.to_s => "3"}

      game.end_game(colony_influence)

      game.completed?.should == true
      game.game_players.first.colony_influence.should == 1
      game.game_players.second.colony_influence.should == 3
    end
  end

  describe "set_current_player" do
    it "should set the current_player to the game_player with the first turn order on create" do
      game = FactoryGirl.build(:game)
      game.game_players << FactoryGirl.build(:game_player, turn_order: 3)
      game.game_players.first.turn_order = 3
      game.game_players.second.turn_order = 1
      game.game_players.third.turn_order = 2

      game.save

      game.game_players.size.should == 3
      game.current_player.should == game.game_players.second
    end
  end

  describe "players_by_score" do
    it "should description" do
      pending
    end
  end

end
