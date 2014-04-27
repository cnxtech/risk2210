require 'spec_helper'

describe GamesController do

  let(:player1) { FactoryGirl.create(:player) }
  let(:player2) { FactoryGirl.create(:player) }
  let(:faction_ids) { Faction.all.map(&:id).sample(2) }
  let(:map_ids) { Map.all.map(&:id).sample(2) }

  describe "new" do
    it "should render a form and have 2 game players" do
      login player1

      get :new

      expect(assigns(:game)).to_not be_nil
      expect(assigns(:game).game_players.first.handle).to eq(player1.handle)
      expect(assigns(:game).game_players.second).to_not be_nil
    end
  end

  describe "create" do
    it "should create a new game" do
      login player1

      ## Setup game
      game_players = {}
      game_players["0"] = {color: "Blue", handle: player1.handle, faction_id: faction_ids[0], turn_order: 1}
      game_players["1"] = {color: "Green", handle: player2.handle, faction_id: faction_ids[1], turn_order: 2}

      post :create, game: {game_players_attributes: game_players, map_ids: map_ids, location: "Chicago"}

      expect(response).to redirect_to game_path(assigns(:game))
      expect(assigns(:game).creator).to eq(player1)
      expect(flash[:notice]).to_not be_nil
    end
    it "should reload the page if there were any errors" do
      login player1

      post :create, game: {game_players_attributes: {}, map_ids: [], location: "Chicago"}

      expect(response).to render_template :new
      expect(flash.now[:alert]).to_not be_nil
    end
  end

  describe "show" do
    it "should have the game and render successfully" do
      game = FactoryGirl.create(:game)

      get :show, id: game

      expect(assigns(:game)).to eq(game)
      expect(response).to be_success
    end
  end

  describe "destroy" do

    let!(:game) { FactoryGirl.create(:game, creator_id: player1.id) }

    it "should remove the game if the current player is the creator" do
      login player1

      expect{
        delete :destroy, id: game.id
      }.to change(Game, :count).by(-1)

      expect(response).to redirect_to root_path
      expect(flash.notice).to_not be_nil
    end
    it "should display an alert if the current player is not the creator" do
      login player2

      expect{
        delete :destroy, id: game.id
      }.to change(Game, :count).by(0)

      expect(response).to redirect_to root_path
      expect(flash.alert).to_not be_nil
    end
  end

  describe "results" do
    it "should have the game and render successfully" do
      game = FactoryGirl.create(:game, completed: true)

      get :results, id: game

      expect(assigns(:game)).to eq(game)
      expect(response).to be_success
    end
    it "should redirect to the game#show if the game isn't complete" do
      game = FactoryGirl.create(:game, completed: false)

      get :results, id: game

      expect(response).to redirect_to game_path(game)
    end
  end

  describe "update" do
    let(:game) { FactoryGirl.create(:game, creator_id: player1.id, current_year: 1) }
    let(:game_player) { game.game_players.first }
    let(:game_player2) { game.game_players.second }

    it "should display an alert if the current player is not the creator" do
      login player2

      put :update, id: game.id, event: "start_year", payload: {}

      expect(response).to redirect_to root_path
      expect(flash.alert).to_not be_nil
    end

    context "start_year event" do
      before {login player1}
      it "triggers the start the next year in the game" do
        put :update, id: game.id, event: "start_year", payload: {"#{game_player.id}" => "2", "#{game_player2.id}" => "1"}

        expect(response).to be_success
        expect(game.reload.current_year).to eq(2)
        expect(game_player.reload.turn_order).to eq(2)
        expect(game_player2.reload.turn_order).to eq(1)
      end
      it "returns error messages if the new year fails to start" do
        put :update, id: game.id, event: "start_year", payload: {"#{game_player.id}" => "2", "#{game_player2.id}" => "2"}

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:base]).to include("Every player must have a unique starting turn order.")
        expect(response).to_not be_success
        expect(game.reload.current_year).to eq(1)
        expect(game_player.reload.turn_order).to eq(1)
        expect(game_player2.reload.turn_order).to eq(2)
      end
    end

    context "end_game event" do
      it "should update the game player's colony influence" do
        login player1

        put :update, id: game.id, event: "end_game", payload: {"#{game_player.id}" => "2", "#{game_player2.id}" => "3"}

        expect(response).to be_success
        expect(game.reload).to be_completed
        expect(game_player.reload.colony_influence).to eq(2)
        expect(game_player2.reload.colony_influence).to eq(3)
      end
    end
  end

end
