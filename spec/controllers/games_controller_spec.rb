require 'spec_helper'

describe GamesController do

  let(:player1) { FactoryGirl.create(:player) }
  let(:player2) { FactoryGirl.create(:player) }
  let(:continent_ids) { Continent.all.map(&:id).sample(4) }
  let(:faction_ids) { Faction.all.map(&:id).sample(2) }
  let(:map_ids) { Map.all.map(&:id).sample(2) }

  describe "new" do
    it "should render a form and have 2 game players" do
      login player1

      get :new

      assigns(:game).should_not be_nil
      assigns(:game).game_players.first.player.should == player1
      assigns(:game).game_players.second.should_not be_nil
    end
  end

  describe "create" do
    it "should create a new game" do
      login player1

      ## Setup game
      game_players = {}
      game_players["0"] = {color: "Blue", player_id: player1.id, faction_id: faction_ids[0]}
      game_players["1"] = {color: "Green", player_id: player2.id, faction_id: faction_ids[1]}

      post :create, game: {game_players_attributes: game_players, map_ids: map_ids, location: "Chicago"}

      response.should redirect_to game_path(assigns(:game))
      assigns(:game).creator.should == player1
      flash[:notice].should_not be_nil
    end
    it "should reload the page if there were any errors" do
      login player1

      post :create, game: {game_players_attributes: {}, map_ids: [], location: "Chicago"}

      response.should render_template :new
      flash.now[:alert].should_not be_nil
    end
  end

  describe "show" do
    it "should description" do
      game_players = {}
      game_players["0"] = {color: "Blue", player_id: player1.id, faction_id: faction_ids[0]}
      game_players["1"] = {color: "Green", player_id: player2.id, faction_id: faction_ids[1]}
      game = FactoryGirl.create(:game, map_ids: map_ids, game_players_attributes: game_players)

      get :show, id: game

      response.should be_success
    end
  end

end
