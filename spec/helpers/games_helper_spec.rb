require 'spec_helper'

describe GamesHelper do

  let(:game) { FactoryGirl.build(:game) }

  describe "progress_bar" do
    it "should return a div with the game progress bar" do
      allow(game).to receive(:percent_complete).and_return(50.0)

      expect(helper.progress_bar(game, id: "game")).to eq "<div class=\"progress progress-danger\" id=\"game\"><div class=\"bar\" style=\"width: 50.0%;\"></div></div>"
    end
  end

  describe "player_handles" do
    let!(:player1) { FactoryGirl.create(:player) }
    let!(:player2) { FactoryGirl.create(:player) }

    it "should return a formatted array of player handles for Bootstraps's typeahead" do
      expect(helper.player_handles).to eq "[\"#{player1.handle}\", \"#{player2.handle}\"]"
    end
  end

end
