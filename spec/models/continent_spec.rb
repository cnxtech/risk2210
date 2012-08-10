require 'spec_helper'

describe Continent do
  
  describe "ordered" do
    it "should order continents by type first and then by name" do
      aland = FactoryGirl.create(:land_continent, name: "a")
      awater = FactoryGirl.create(:water_continent, name: "a")
      alava = FactoryGirl.create(:lava_continent, name: "a")
      alunar = FactoryGirl.create(:lunar_continent, name: "a")
      tlunar = FactoryGirl.create(:lunar_continent, name: "t")
      twater = FactoryGirl.create(:water_continent, name: "t")
      tland = FactoryGirl.create(:land_continent, name: "t")
      tlava = FactoryGirl.create(:lava_continent, name: "t")

      continents = Continent.ordered

      continents.should == [aland, tland, alava, tlava, alunar, tlunar, awater, twater]
    end
  end

end
