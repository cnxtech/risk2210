require 'spec_helper'

describe TurnsController do

  let(:player1) { FactoryGirl.create(:player) }
  let(:player2) { FactoryGirl.create(:player) }
  let(:continent_ids_1) { Continent.all.map(&:id).sample(4) }
  let(:continent_ids_2) { Continent.all.map(&:id).sample(4) }

  before do
    @game = FactoryGirl.create(:game, creator_id: player1.id, current_year: 1)
    @game_player = @game.game_players.first
    @game_player2 = @game.game_players.second
  end

  describe "create" do
    it "should create a turn and a record for each player of the game" do
      login player1

      expect {
        post :create,
          game_id: @game.id,
          game_player_id: @game_player.id,
          year: 1,
          order: 1,
          game_player_stats_attributes: [
          {
            game_player_id: @game_player.id,
            energy:           21,
            units:            21,
            territory_count:  20,
            continent_ids: continent_ids_1
          },
          {
            game_player_id: @game_player2.id,
            energy:           14,
            units:            14,
            territory_count:  14,
            continent_ids: continent_ids_2
          }
        ]
      }.to change(Turn, :count).by(1)

      json = JSON.parse(response.body, symbolize_names: true)
      json[:game_id].should == @game.id.to_s
      json[:game_player_stats].size.should == 2
      response.should be_success
    end
    it "should respond with errors if the turn doesn't save" do
      login player1

      expect {
        post :create,
          game_id: @game.id,
          game_player_id: "",
          year: 2,
          turn_order: 3,
          game_player_stats_attributes: [{
            energy: 14,
            units: 14,
            territory_count: 20,
            continent_ids: continent_ids_1
          }
        ]
      }.to change(Turn, :count).by(0)

      json = JSON.parse(response.body, symbolize_names: true)
      json[:game_player_id].should == ["can't be blank"]
      response.status.should == 406
    end
    it "doesn't allow another player to add turns" do
      login player2

      expect {
       post :create,
        game_id: @game.id,
        game_player_id: @game_player.id,
        turn_order: 3,
        year: 2,
        game_player_stats_attributes: [{
          energy: 14,
          units: 14,
          territorie_count: 20,
          continent_ids: continent_ids_1
        }]
      }.to change(Turn, :count).by(0)

      response.status.should == 401
    end
  end

  describe "start_year" do
    before do
      login player1
    end
    it "triggers the start the next year in the game" do
      put :start_year, game_id: @game.id, turn_order: {"#{@game_player.id}" => "2", "#{@game_player2.id}" => "1"}

      response.should be_success
      @game.reload.current_year.should == 2
      @game_player.reload.turn_order.should == 2
      @game_player2.reload.turn_order.should == 1
    end
    it "returns error messages if the new year fails to start" do
      put :start_year, game_id: @game.id, turn_order: {"#{@game_player.id}" => "2", "#{@game_player2.id}" => "2"}

      response.should_not be_success
      game = JSON.parse(response.body, symbolize_names: true)
      game[:base].include?("Every player must have a unique starting turn order.").should == true
      @game.reload.current_year.should == 1
      @game_player.reload.turn_order.should == 1
      @game_player2.reload.turn_order.should == 2
    end
  end

  describe "end_game" do
    before do
      login player1
    end
    it "should update the game player's colony influence" do
      put :end_game, game_id: @game.id, colony_influence: {"#{@game_player.id}" => "2", "#{@game_player2.id}" => "3"}

      response.should be_success
      @game.reload.completed?.should == true
      @game_player.reload.colony_influence.should == 2
      @game_player2.reload.colony_influence.should == 3
    end
  end

end
