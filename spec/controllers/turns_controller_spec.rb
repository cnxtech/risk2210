require 'spec_helper'

describe TurnsController do

  let(:player1) { FactoryGirl.create(:player) }
  let(:player2) { FactoryGirl.create(:player) }
  let(:continent_ids_1) { Continent.all.map(&:id).sample(4) }
  let(:continent_ids_2) { Continent.all.map(&:id).sample(4) }
  let(:faction_ids) { Faction.all.map(&:id).sample(2) }
  let(:map_ids) { Map.all.map(&:id).sample(2) }

  before do
    game_players = {}
    game_players["0"] = {color: "Blue", handle: player1.handle, faction_id: faction_ids[0], turn_order: 1}
    game_players["1"] = {color: "Green", handle: player2.handle, faction_id: faction_ids[1], turn_order: 2}
    @game = FactoryGirl.create(:game, map_ids: map_ids, game_players_attributes: game_players, creator_id: player1.id)
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
          turn_order: 1,
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

end
