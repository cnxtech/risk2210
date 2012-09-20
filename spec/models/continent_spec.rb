require 'spec_helper'

describe Continent do

  before do
    load("#{Rails.root}/db/maps.rb")
  end
  
  describe "ordered" do
    it "should order continents by type first and then by name" do
      continents = Continent.ordered.map(&:name)

      continents.should == ["Africa", "Amazonis", "Angeln", "Arcadia", "Asia", "Australia", "Automin", "Avalon", "Balt", "Byfed", "Casius", "Cymru", "Ecclesia", "Eden", "Europe", "Galilei", "Ghaul", "Granada", "Hoenheim", "Narkom", "North America", "Seaxna", "Skandi", "South America", "Tharsis", "Ugricya", "Vulcan", "Caprica", "Khell", "Magreb", "Mashriq", "Nuraghe", "Soter", "1 Ceres", "243 Ida", "4 Vesta", "Cresinion", "Dactyl", "Delphot", "Federation", "New America", "Norseland", "Sajon", "Acidalium", "Arabia", "Asia Pacific", "Indian", "Isidis", "North Atlantic", "Propontis", "South Atlantic", "SungTzu", "US Pacific", "Utopia"]
    end
  end

end
