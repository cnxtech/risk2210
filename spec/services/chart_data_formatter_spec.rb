require 'spec_helper'

describe ChartDataFormatter do

  before do
    @game = FactoryGirl.create(:game)
    game_player1 = @game.game_players[0]
    game_player2 = @game.game_players[1]

    5.times do
      game_player1_turn = FactoryGirl.create(:turn, game: @game, game_player: game_player1)
      FactoryGirl.create(:game_player_stat, turn: game_player1_turn, game_player: game_player1)
      FactoryGirl.create(:game_player_stat, turn: game_player1_turn, game_player: game_player2)

      game_player2_turn = FactoryGirl.create(:turn, game: @game, game_player: game_player2)
      FactoryGirl.create(:game_player_stat, turn: game_player2_turn, game_player: game_player1)
      FactoryGirl.create(:game_player_stat, turn: game_player2_turn, game_player: game_player2)
    end

    @chart_data_formatter = ChartDataFormatter.new(@game)
  end

  describe "metric methods" do
    it "should define territories, energy, units, and space_stations metric methods" do
      @chart_data_formatter.respond_to?(:territories).should == true
      @chart_data_formatter.respond_to?(:energy).should == true
      @chart_data_formatter.respond_to?(:units).should == true
      @chart_data_formatter.respond_to?(:space_stations).should == true
    end
    it "should return the data formatted correctly" do
      @chart_data_formatter.territories.is_a?(Array).should == true
      @chart_data_formatter.territories[0].is_a?(Hash).should == true
      @chart_data_formatter.territories[0][:key].should_not be_nil
      @chart_data_formatter.territories[0][:color].should_not be_nil
      @chart_data_formatter.territories[0][:values].is_a?(Array).should == true
      @chart_data_formatter.territories[0][:values][0].is_a?(Array).should == true
    end
  end

end
