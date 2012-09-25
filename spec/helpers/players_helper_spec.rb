require 'spec_helper'

describe PlayersHelper do
  
  describe "us_states_options" do
    it "should return an array of us states options" do
      helper.us_states_options.is_a?(Array).should == true
    end
  end

  describe "avatar" do
    let(:player) { FactoryGirl.create(:player, handle: "Payton Dog") }
    it "should return the player's avatar for the size requested" do
      avatar_image = helper.avatar(player)

      avatar_image.should == '<img alt="Payton Dog" src="http://risk2210.net/assets/default_avatar.png" width="150px;" />'
    end
    it "should allow me to use a smaller image" do
      avatar_image = helper.avatar(player, size: :small)

      avatar_image.should == '<img alt="Payton Dog" src="http://risk2210.net/assets/default_avatar.png" width="50px;" />'
    end
  end

end
