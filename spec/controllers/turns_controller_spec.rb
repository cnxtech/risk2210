require 'rails_helper'

describe TurnsController do

  let(:player1) { create(:player) }
  let(:player2) { create(:player) }
  let(:continent_ids_1) { Continent.all.map(&:id).sample(4) }
  let(:continent_ids_2) { Continent.all.map(&:id).sample(4) }
  let(:game) { create(:game, creator_id: player1.id, current_year: 1) }
  let(:game_player) { game.game_players[0] }
  let(:game_player2) { game.game_players[1] }

  describe "create" do
    it "should create a turn and a record for each player of the game" do
      login player1

      expect {
        post :create,
          game_id: game.id,
          game_player_id: game_player.id.to_s,
          year: 1,
          order: 1,
          format: :json,
          game_player_stats_attributes: [
          {
            game_player_id: game_player.id.to_s,
            energy:           21,
            units:            21,
            territory_count:  20,
            continent_ids: continent_ids_1.map(&:to_s)
          },
          {
            game_player_id: game_player2.id.to_s,
            energy:           14,
            units:            14,
            territory_count:  14,
            continent_ids: continent_ids_2.map(&:to_s)
          }
        ]
      }.to change(Turn, :count).by(1)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:game_id]).to eq(game.id.to_s)
      expect(json[:game_player_stats].size).to eq(2)
      expect(json[:game_player_stats].detect{ |game_player_stat| game_player_stat[:game_player_id] == game_player.id.to_s }[:continent_ids]).to match(continent_ids_1.map(&:to_s))
      expect(json[:game_player_stats].detect{ |game_player_stat| game_player_stat[:game_player_id] == game_player2.id.to_s }[:continent_ids]).to match(continent_ids_2.map(&:to_s))
      expect(response).to be_success
    end
    it "should respond with errors if the turn doesn't save" do
      login player1

      expect {
        post :create,
          game_id: game.id.to_s,
          game_player_id: "",
          year: 2,
          turn_order: 3,
          format: :json,
          game_player_stats_attributes: [{
            energy: 14,
            units: 14,
            territory_count: 20,
            continent_ids: continent_ids_1.map(&:to_s)
          }
        ]
      }.to change(Turn, :count).by(0)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:game_player_id]).to eq ["can't be blank"]
      expect(response.status).to eq(406)
    end
    it "doesn't allow another player to add turns" do
      login player2

      expect {
       post :create,
        game_id: game.id.to_s,
        game_player_id: game_player.id.to_s,
        turn_order: 3,
        year: 2,
        format: :json,
        game_player_stats_attributes: [{
          energy: 14,
          units: 14,
          territorie_count: 20,
          continent_ids: continent_ids_1.map(&:to_s)
        }]
      }.to change(Turn, :count).by(0)

      expect(response.status).to eq(401)
    end
  end

end
