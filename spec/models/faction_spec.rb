require 'spec_helper'

describe Faction do

  before do
    load_factions
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

  describe "non_default" do
    it "should return all factions except the default one" do
      default_faction = Faction.where(name: "Default")
      factions = Faction.non_default

      factions.size.should == 11
      factions.include?(default_faction).should == false
    end
  end

  describe "random" do
    it "should return a random faction" do
      faction = Faction.random

      faction.is_a?(Faction).should == true
    end
  end

  describe "min_energy" do
    it "should be 4 if faction is The Fusion Conservancy otherwise it should be 3" do
      Faction.all.each do |faction|
        if faction.fusion_conservancy?
          faction.min_energy.should == 4
        else
          faction.min_energy.should == 3
        end
      end
    end
  end

  describe "min_units" do
    it "should be 4 if faction is MegaCorp otherwise it should be 3" do
      Faction.all.each do |faction|
        if faction.mega_corp?
          faction.min_units.should == 4
        else
          faction.min_units.should == 3
        end
      end
    end
  end

  describe "image_name_format" do
    it "should downcase the name and replace spaces" do
      faction = Faction.where(name: "Primus Oceanus").first

      faction.image_name_format.should == "primus_oceanus"
    end
  end

end
