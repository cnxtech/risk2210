require 'spec_helper'

describe Continent do

  describe "ordered" do
    it "should order continents by type first and then by name" do
      continents = Continent.ordered.map(&:name)

      continents.size.should == 61
      continents.should == ["Africa", "Amazonis", "Angeln", "Arcadia", "Asia", "Australia", "Automin", "Avalon", "Balt", "Byfed", "Casius", "Cymru", "Ecclesia", "Eden", "Elysia", "Europe", "Galilei", "Ghaul", "Granada", "Hoenheim", "Narkom", "North America", "Seaxna", "Skandi", "South America", "Tartarus", "Tharsis", "Titaniya", "Ugricya", "Vulcan", "1 Ceres", "243 Ida", "4 Vesta", "Cresinion", "Dactyl", "Delphot", "Federation", "Jotunheim", "New America", "Norseland", "Sajon", "Styx", "Acidalium", "Arabia", "Arctic (Post Warming)", "Arctic (Pre Warming)", "Asia Pacific", "Caprica", "Indian", "Isidis", "Khell", "Magreb", "Mashriq", "North Atlantic", "Nuraghe", "Propontis", "Soter", "South Atlantic", "SungTzu", "US Pacific", "Utopia"]
    end
  end

end
