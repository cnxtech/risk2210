require 'spec_helper'

describe Faction do

  before do
    load("#{Rails.root}/db/factions.rb")
    load("#{Rails.root}/db/maps.rb")
  end

  describe "starting_resources" do
    it "should return an array of starting resources" do
      Faction.random.starting_resources.is_a?(Array).should == true
    end
  end

  describe "fusion_conservancy?" do
    it "should return true if the faction is The Fusion Conservancy" do
      Faction.where(name: "The Fusion Conservancy").first.fusion_conservancy?.should == true
    end
  end

  describe "mega_corp?" do
    it "should return true if the faction is the MegaCorp" do
      Faction.where(name: "MegaCorp").first.mega_corp?.should == true
    end
  end

end
