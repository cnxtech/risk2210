require 'rails_helper'

describe PlayersHelper do

  describe "us_states_options" do
    it "should return an array of us states options" do
      expect(helper.us_states_options).to be_a(Array)
    end
  end

  describe "avatar" do
    let(:player) { FactoryGirl.create(:player, handle: "Payton Dog") }
    it "should return the player's avatar for the size requested" do
      avatar_image = helper.avatar(player)

      expect(avatar_image).to eq '<img width="170px;" alt="Payton Dog" class="img-rounded" src="https://risk2210.net/assets/default_avatar.png" />'
    end
    it "should allow me to use a smaller image" do
      avatar_image = helper.avatar(player, size: :small)

      expect(avatar_image).to eq '<img width="50px;" alt="Payton Dog" class="img-rounded" src="https://risk2210.net/assets/default_avatar.png" />'
    end
  end

  describe "nearby_players" do
    it "should return nothing if there is no current user" do
      expect(helper.nearby_players(nil)).to be_nil
    end
    it "should return a message if the player hasn't entered a location" do
      player = FactoryGirl.create(:player, city: nil, state: nil, zip_code: nil)

      expect(helper.nearby_players(player)).to match(/to see nearby Risk 2210 players./)
    end
    it "should return a message if there are no nearby players" do
      player = FactoryGirl.create(:player, city: "Chicago", state: "IL", zip_code: "60640")

      expect(helper.nearby_players(player)).to match(/Sorry, there are no other Risk 2210 players nearby./)
    end
    it "should render the nearby_players partial" do
      player = FactoryGirl.create(:player, city: "Chicago", state: "IL", zip_code: "60640")
      nearby_player = FactoryGirl.create(:player, city: "Chicago", state: "IL", zip_code: "60640")

      expect(helper.nearby_players(player)).to match(/<a href="\/players\/#{nearby_player.slug}">#{nearby_player.slug}<\/a>/)
    end
  end

  describe "message_link" do
    it "should return nothing if there is no current player" do
      expect(helper.message_link(nil, double(:player))).to be_nil
    end
    it "should return a link to message the player" do
      player = FactoryGirl.create(:player)
      other_player = FactoryGirl.create(:player)

      expect(helper.message_link(player, other_player)).to eq "<a class=\"btn btn-xs btn-info\" href=\"/messages/new?recipient=#{other_player.slug}\"><i class=\"fa fa-envelope\"></i> Message</a>"
    end
  end

end
