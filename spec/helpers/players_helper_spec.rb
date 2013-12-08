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

      avatar_image.should == '<img alt="Payton Dog" src="https://risk2210.net/assets/default_avatar.png" width="150px;" />'
    end
    it "should allow me to use a smaller image" do
      avatar_image = helper.avatar(player, size: :small)

      avatar_image.should == '<img alt="Payton Dog" src="https://risk2210.net/assets/default_avatar.png" width="50px;" />'
    end
  end

  describe "nearby_players" do
    it "should return nothing if there is no current user" do
      helper.stub(:current_player).and_return(nil)

      helper.nearby_players.should be_nil
    end
    it "should return a message if the player hasn't entered a location" do
      player = FactoryGirl.create(:player, city: nil, state: nil, zip_code: nil)
      helper.stub(:current_player).and_return(player)

      helper.nearby_players.match(/location settings to see nearby Risk 2210 players./).should_not be_nil
    end
    it "should return a message if there are no nearby players" do
      player = FactoryGirl.create(:player, city: "Chicago", state: "IL", zip_code: "60640")
      helper.stub(:current_player).and_return(player)

      helper.nearby_players.match(/Sorry, there are no other Risk 2210 players nearby./).should_not be_nil
    end
    it "should render the nearby_players partial" do
      player = FactoryGirl.create(:player, city: "Chicago", state: "IL", zip_code: "60640")
      nearby_player = FactoryGirl.create(:player, city: "Chicago", state: "IL", zip_code: "60640")
      helper.stub(:current_player).and_return(player)

      helper.nearby_players.match(/<a href="\/players\/#{nearby_player.slug}">#{nearby_player.slug}<\/a>/).should_not be_nil
    end
  end

  describe "message_link" do
    it "should return nothing if there is no current player" do
      helper.stub(:current_player).and_return(nil)

      helper.message_link(double(:player)).should == nil
    end
    it "should return a link to message the player" do
      player = FactoryGirl.create(:player)
      other_player = FactoryGirl.create(:player)
      helper.stub(:current_player).and_return(player)

      helper.message_link(other_player).should == "<a href=\"/messages/new?recipient=#{other_player.slug}\" class=\"btn btn-mini btn-info\"><i class=\"icon-envelope\"></i> Message</a>"
    end
  end

end
