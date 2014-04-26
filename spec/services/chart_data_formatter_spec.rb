require 'spec_helper'

describe ChartDataFormatter do

  subject(:chart_data_formatter) { ChartDataFormatter.new(game, formatter: "to_a") }

  let(:game) { FactoryGirl.create(:game) }

  let(:game_player1) { game.game_players[0] }
  let(:game_player2) { game.game_players[1] }

  before do
    5.times do
      game_player1_turn = FactoryGirl.create(:turn, game: game, game_player: game_player1)
      FactoryGirl.create(:game_player_stat, turn: game_player1_turn, game_player: game_player1)
      FactoryGirl.create(:game_player_stat, turn: game_player1_turn, game_player: game_player2)

      game_player2_turn = FactoryGirl.create(:turn, game: game, game_player: game_player2)
      FactoryGirl.create(:game_player_stat, turn: game_player2_turn, game_player: game_player1)
      FactoryGirl.create(:game_player_stat, turn: game_player2_turn, game_player: game_player2)
    end
  end

  describe "metric methods" do
    it "should define territories, energy, units, and space_stations metric methods" do
      expect(chart_data_formatter).to respond_to(:territories)
      expect(chart_data_formatter).to respond_to(:energy)
      expect(chart_data_formatter).to respond_to(:units)
      expect(chart_data_formatter).to respond_to(:space_stations)
      expect(chart_data_formatter).to respond_to(:continent_bonus)
    end
    it "should return the data formatted correctly" do
      expect(chart_data_formatter.territories).to be_a(Array)
      expect(chart_data_formatter.territories[0]).to be_a(Hash)
      expect(chart_data_formatter.territories[0][:key]).to_not be_nil
      expect(chart_data_formatter.territories[0][:color]).to_not be_nil
      expect(chart_data_formatter.territories[0][:values]).to be_a(Array)
      expect(chart_data_formatter.territories[0][:values][0]).to be_a(Array)
    end
  end

end
