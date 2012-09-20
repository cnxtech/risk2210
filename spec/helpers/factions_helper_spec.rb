require 'spec_helper'

describe FactionsHelper do

  before do
    load("#{Rails.root}/db/factions.rb")
    @church_of_him = Faction.where(name: "Church of Him").first
  end

  describe "faction_card_image" do
    it "should return the image tag for the faction card image" do
      tag = helper.faction_card_image(@church_of_him)

      tag.should =~ /faction_cards\/church_of_him.jpg/
    end
  end

  describe "faction_icon" do
    it "should return the image tag for the faction icon" do
      tag = helper.faction_icon(@church_of_him)

      tag.should =~ /faction_icons\/church_of_him.png/
    end
    it "should allow me to overide the width" do
      tag = helper.faction_icon(@church_of_him, 25)

      tag.should =~ /width="25"/
    end
  end

end
