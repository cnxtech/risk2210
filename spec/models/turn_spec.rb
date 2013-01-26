require 'spec_helper'

describe Turn do

  let(:game) { FactoryGirl.create(:game, current_year: 2) }

  describe "update_game_year" do
    it "should update the year counter on the game if the last turn has been saved" do
      first_turn = FactoryGirl.create(:turn, game: game, order: 1)
      second_turn = FactoryGirl.create(:turn, game: game, order: 2)

      game.reload.current_year.should == 3
    end
  end

  describe "last?" do
    it "should be true if the the turn order saved is the last of the year" do
      first_turn = FactoryGirl.create(:turn, game: game, order: 1)
      second_turn = FactoryGirl.build(:turn, game: game, order: 2)

      first_turn.last?.should == false
      second_turn.last?.should == true
    end
  end

end
