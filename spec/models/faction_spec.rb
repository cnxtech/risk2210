require 'rails_helper'

describe Faction do

  describe "starting_resources" do
    it "should return an array of starting resources" do
      faction = Faction.random
      expect(faction.starting_resources).to be_a(Array)
    end
  end

  describe "fusion_conservancy?" do
    it "should return true if the faction is The Fusion Conservancy" do
      faction = Faction.where(name: "The Fusion Conservancy").first
      expect(faction).to be_fusion_conservancy
    end
  end

  describe "mega_corp?" do
    it "should return true if the faction is the MegaCorp" do
      faction = Faction.where(name: "MegaCorp").first
      expect(faction).to be_mega_corp
    end
  end

  describe "default?" do
    it "should return true if the faction is Default" do
      faction = Faction.where(name: "Default").first
      expect(faction).to be_default
    end
  end

  describe "non_default" do
    it "should return all factions except the default one" do
      default_faction = Faction.where(name: "Default")
      factions = Faction.non_default

      expect(factions.size).to eq(11)
      expect(factions).to_not include(default_faction)
    end
  end

  describe "random" do
    it "should return a random faction" do
      faction = Faction.random

      expect(faction).to be_a(Faction)
    end
  end

  describe "min_energy" do
    it "should be 4 if faction is The Fusion Conservancy otherwise it should be 3" do
      Faction.all.each do |faction|
        if faction.fusion_conservancy?
          expect(faction.min_energy).to eq(4)
        else
          expect(faction.min_energy).to eq(3)
        end
      end
    end
  end

  describe "min_units" do
    it "should be 4 if faction is MegaCorp otherwise it should be 3" do
      Faction.all.each do |faction|
        if faction.mega_corp?
          expect(faction.min_units).to eq(4)
        else
          expect(faction.min_units).to eq(3)
        end
      end
    end
  end

  describe "image_name_format" do
    it "should downcase the name and replace spaces" do
      faction = Faction.where(name: "Primus Oceanus").first

      expect(faction.image_name_format).to eq("primus_oceanus")
    end
  end

end
