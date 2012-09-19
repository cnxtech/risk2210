require 'spec_helper'

describe FactionsHelper do

  let(:faction) { FactoryGirl.create(:faction, name: "Mega Corp") }

  describe "faction_card_image" do
    it "should return the image tag for the faction card image" do
      tag = helper.faction_card_image(faction)

      tag.should =~ /faction_cards\/mega_corp.jpg/
    end
  end

  describe "faction_icon" do
    it "should return the image tag for the faction icon" do
      tag = helper.faction_icon(faction)

      tag.should =~ /faction_icons\/mega_corp.png/
    end
    it "should allow me to overide the width" do
      tag = helper.faction_icon(faction, 25)

      tag.should =~ /width="25"/
    end
  end

end
