require 'rails_helper'

describe GamesHelper do

  let(:game) { build(:game) }

  describe "progress_bar" do
    it "should return a div with the game progress bar" do
      allow(game).to receive(:percent_complete).and_return(50.0)

      expect(helper.progress_bar(game, id: "game")).to eq("<div class=\"progress\"><div class=\"progress-bar progress-bar-danger\" id=\"game\" role=\"progressbar\" aria-valuenow=\"50.0\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 50.0%;\"><span class=\"sr-only\">50.0% Complete</span></div></div>")
    end
  end

  describe "player_handles" do
    let!(:player1) { create(:player) }
    let!(:player2) { create(:player) }

    it "should return a formatted array of player handles for Bootstraps's typeahead" do
      expect(helper.player_handles).to eq "[\"#{player1.handle}\", \"#{player2.handle}\"]"
    end
  end

end
