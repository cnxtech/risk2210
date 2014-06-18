require 'rails_helper'

describe Continent do

  describe "ordered" do
    it "should order continents by type first and then by name" do
      continents = Continent.ordered.map(&:name)

      expect(continents.size).to eq(81)
      expect(continents).to eq ["Africa", "Amazonis", "Angeln", "Arcadia", "Asia", "Australia", "Automin", "Avalon", "Balt", "Byfed", "Casius", "Cassiopia", "Concordia", "Cymru", "Ecclesia", "Eden", "Elysia", "Europe", "Galilei", "Ghaul", "Granada", "Hoenheim", "Narkom", "New Palestine", "North America", "Seaxna", "Skandi", "South America", "Tartarus", "Tharsis", "Titan", "Titaniya", "Tsegihi", "Ugricya", "Vespucci", "Vulcan", "Xanadu", "1 Ceres", "243 Ida", "4 Vesta", "Cresinion", "Dactyl", "Delphot", "Federation", "Free Siberiana", "Jotunheim", "New America", "Norseland", "North Luna", "Sajon", "South Luna", "Styx", "Yok", "Acidalium", "Arabia", "Arctic (Post Warming)", "Arctic (Pre Warming)", "Asia Pacific", "Caprica", "Fensal", "Hydraxis", "Indian", "Isidis", "Khell", "Lacus", "Legate", "Magreb", "Mashriq", "Mezoramia", "Mindando Fac.", "North Atlantic", "Novaya Rossiya", "Nuraghe", "Propontis", "Sangri-La", "Senkyo", "Soter", "South Atlantic", "SungTzu", "US Pacific", "Utopia"]
    end
  end

end
