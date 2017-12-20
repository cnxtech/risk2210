require 'rails_helper'

describe Game do

  let(:map_ids) { Map.all.sample(3).map(&:id) }
  let(:faction_ids) { Faction.all.sample(2).map(&:id) }
  let(:game) { create(:game, map_ids: map_ids[0..1]) }

  describe "has_map?" do
    it "should return true if a game has a map" do
      expect(game.has_map?(Map.find(map_ids[0]))).to be_truthy
      expect(game.has_map?(Map.find(map_ids[1]))).to be_truthy
      expect(game.has_map?(Map.find(map_ids[2]))).to be_falsey
    end
  end

  describe "map_names" do
    it "should join the map names" do
      expect(game.map_names).to eq("#{game.maps[0].name} and #{game.maps[1].name}")
    end
  end

  describe "percent_complete" do
    it "should return the percentage of the game that has been completed" do
      3.times do
        create(:turn, game: game, game_player: game.game_players.first)
        create(:turn, game: game, game_player: game.game_players.second)
      end

      expect(game.percent_complete).to eq(60.0)
    end
  end

  describe "turn_count" do
    it "should return the total number of turns the game has" do
      3.times do
        create(:turn, game: game, game_player: game.game_players.first)
        create(:turn, game: game, game_player: game.game_players.second)
      end

      expect(game.turn_count).to eq(6)
    end
  end

  describe "validations" do

    let(:game_player_attributes) { Hash.new }

    before do
      2.times do |index|
        player = create(:player)
        game_player_attributes[index.to_s] = {handle: player.handle, faction_id: faction_ids[index], color: GamePlayer::COLORS.sample, turn_order: index + 1}
      end
    end

    it "should be invalid with less than 2 players" do
      game = Game.new(map_ids: map_ids[0..1])

      expect(game).to_not be_valid
      expect(game.errors[:base]).to include("You must have at least two players.")
    end
    it "should be invalid with more than 5 players" do
      4.times do |index|
        player = create(:player)
        game_player_attributes[(index + 2).to_s] = {handle: player.handle, faction_id: faction_ids[index], color: GamePlayer::COLORS.sample}
      end

      game = FactoryGirl.build(:game, map_ids: map_ids[0..1], game_players_attributes: game_player_attributes)

      expect(game).to_not be_valid
      expect(game.errors[:base]).to include("You can't have more than five players.")
    end
    it "should be invalid without any maps" do
      game = FactoryGirl.build(:game, map_ids: [], game_players_attributes: game_player_attributes)

      expect(game).to_not be_valid
      expect(game.errors[:base]).to include("You must choose one or more maps to play.")
    end
    it "should be invalid if all players don't have a unique starting turn order" do
      game_player_attributes["1"][:turn_order] = 1
      game = FactoryGirl.build(:game, map_ids: map_ids[0..1], game_players_attributes: game_player_attributes)

      expect(game).to_not be_valid
      expect(game.errors[:base]).to include("Every player must have a unique starting turn order.")
    end
  end

  describe "save_event" do
    let(:game) { create(:game, current_year: 1) }
    context "start_year" do
      it "should increment the year and set each game_player's turn order" do
        turn_order = {}
        turn_order[game.game_players[0].id.to_s] = "2"
        turn_order[game.game_players[1].id.to_s] = "1"

        game.save_event("start_year", turn_order)

        expect(game.current_year).to eq(2)
        expect(game.current_player).to eq(game.game_players[1])
        expect(game.game_players[0].turn_order).to eq(2)
        expect(game.game_players[1].turn_order).to eq(1)
      end
      it "should populate errors if the save fails" do
        turn_order = {}
        turn_order[game.game_players[0].id.to_s] = "2"
        turn_order[game.game_players[1].id.to_s] = "2"

        game.save_event("start_year", turn_order)

        expect(game.errors[:base]).to include("Every player must have a unique starting turn order.")
      end
    end

    context "end_game" do
      it "should update the player's colony influence and the game's completed flag" do
        colony_influence = {}
        colony_influence[game.game_players[0].id.to_s] = "1"
        colony_influence[game.game_players[1].id.to_s] = "3"

        game.save_event("end_game", colony_influence)

        expect(game).to be_completed
        expect(game.game_players[0].colony_influence).to eq(1)
        expect(game.game_players[1].colony_influence).to eq(3)
      end
    end

    context "update_turn_order" do
      it "should update the turn order without incrementing the year" do
        turn_order = {}
        turn_order[game.game_players[0].id.to_s] = "2"
        turn_order[game.game_players[1].id.to_s] = "1"

        game.save_event("update_turn_order", turn_order)

        expect(game.current_year).to eq(1)
        expect(game.current_player).to eq(game.game_players.second)
        expect(game.game_players[0].turn_order).to eq(2)
        expect(game.game_players[1].turn_order).to eq(1)
      end
    end

    context "invalid event" do
      it "should raise an exception" do
        expect{
          game.save_event("destroy_game", {})
        }.to raise_error(Exception)
      end
    end

  end

  describe "set_current_player" do
    it "should set the current_player to the game_player with the first turn order on create" do
      game = FactoryGirl.build(:game)
      game.game_players << FactoryGirl.build(:game_player, turn_order: 3)
      game.game_players[0].turn_order = 3
      game.game_players[1].turn_order = 1
      game.game_players[2].turn_order = 2

      game.save

      expect(game.game_players.size).to eq(3)
      expect(game.current_player).to eq(game.game_players[1])
    end
  end

  describe "players_by_score" do
    it "should return the game players sorted by score" do
      game = create(:game)
      game_player1 = game.game_players[0]
      game_player2 = game.game_players[1]
      game_player1.update_attribute(:territory_count, 15)
      game_player2.update_attribute(:territory_count, 20)

      expect(game.players_by_score).to eq([game_player2, game_player1])
    end
  end

end
