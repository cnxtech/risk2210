require 'spec_helper'

describe TurnsController do

  let(:player1) { FactoryGirl.create(:player) }
  let(:player2) { FactoryGirl.create(:player) }
  let(:continent_ids) { Continent.all.map(&:id).sample(4) }
  let(:faction_ids) { Faction.all.map(&:id).sample(2) }
  let(:map_ids) { Map.all.map(&:id).sample(2) }

  before do
    load_factions
    load_maps
    
    ## Setup game
    game_players = {}
    game_players["0"] = {color: "Blue", player_id: player1.id, faction_id: faction_ids[0]}
    game_players["1"] = {color: "Green", player_id: player2.id, faction_id: faction_ids[1]}
    @game = FactoryGirl.create(:game, map_ids: map_ids, game_players_attributes: game_players, creator_id: player1.id)
    @game_player = @game.game_players.first
  end

  describe "create" do
    it "should create a turn" do
      login player1

      expect { 
        post :create, game_id: @game.id, game_player_id: @game_player.id, energy_collected: 14, units_collected: 14, territories_held: 20, continent_ids: continent_ids
      }.to change(Turn, :count).by(1)

      json = JSON.parse(response.body, symbolize_names: true)
      json[:game_id].should == @game.id.to_s
      response.should be_success
    end
    it "should respond with errors if the turn doesn't save" do
      login player1
      
      expect {
        post :create, game_id: @game.id, game_player_id: "", energy_collected: 14, units_collected: 14, territories_held: 20, continent_ids: continent_ids
      }.to change(Turn, :count).by(0)

      json = JSON.parse(response.body, symbolize_names: true)
      json[:game_player_id].should == ["can't be blank"]
      response.status.should == 406
    end
  end

end
