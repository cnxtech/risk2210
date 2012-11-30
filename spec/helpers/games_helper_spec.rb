require 'spec_helper'

describe GamesHelper do

  describe "progress_bar" do
    it "should return a div with the game progress bar" do
      game = FactoryGirl.build(:game)
      game.stub(:percent_complete).and_return(50.0)

      progress_bar = helper.progress_bar(game, id: "game")

      progress_bar.should == "<div class=\"progress progress-danger\" id=\"game\"><div class=\"bar\" style=\"width: 50.0%;\"></div></div>"
    end
  end

  describe "player_handles" do
    it "should return a formatted array of player handles for Bootstraps's typeahead" do
      player1 = FactoryGirl.create(:player)
      player2 = FactoryGirl.create(:player)

      helper.player_handles.should == "[\"#{player1.handle}\", \"#{player2.handle}\"]"
    end
  end

end
