require 'rails_helper'

describe FactionsHelper do

  let(:church_of_him) { Faction.where(name: "Church of Him").first }
  let(:default)       { Faction.where(name: "Default").first }

  describe "faction_card_image" do
    it "should return the image tag for the faction card image" do
      tag = helper.faction_card_image(church_of_him)

      expect(tag).to match(/faction_cards\/church_of_him.jpg/)
    end
    it "should return nothing for the default faction" do
      tag = helper.faction_card_image(default)

      expect(tag).to be_nil
    end
  end

  describe "faction_icon" do
    it "should return the image tag for the faction icon" do
      tag = helper.faction_icon(church_of_him)

      expect(tag).to match(/faction_icons\/church_of_him.png/)
    end
    it "should allow me to overide the width" do
      tag = helper.faction_icon(church_of_him, 25)

      expect(tag).to match(/width="25"/)
    end
    it "should return nothing for the default faction" do
      tag = helper.faction_icon(default)

      expect(tag).to be_nil
    end
  end

end
