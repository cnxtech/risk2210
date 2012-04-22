earth = Map.create(:name => "Earth")
Continent.create(map: earth, name: "North America", type: "Land", bonus: 5, color: "#eae74a")
Continent.create(map: earth, name: "South America", type: "Land", bonus: 2, color: "#d2a32d")
Continent.create(map: earth, name: "Africa", type: "Land", bonus: 3, color: "#64b2d6")
Continent.create(map: earth, name: "Asia", type: "Land", bonus: 7, color: "#7cc446")
Continent.create(map: earth, name: "Europe", type: "Land", bonus: 5, color: "#9e51a3")
Continent.create(map: earth, name: "Australia", type: "Land", bonus: 2, color: "#e63629")
Continent.create(map: earth, name: "US Pacific", type: "Water", bonus: 2, color: "#92c8e0")
Continent.create(map: earth, name: "Asia Pacific", type: "Water", bonus: 1, color: "#d1dc38")
Continent.create(map: earth, name: "North Atlantic", type: "Water", bonus: 2, color: "#ef4f1b")
Continent.create(map: earth, name: "South Atlantic", type: "Water", bonus: 1, color: "#79c139")
Continent.create(map: earth, name: "Indian", type: "Water", bonus: 2, color: "#f27115")

moon = Map.create(:name => "Moon", :moon => true)
Continent.create(map: moon, name: "Sajon", type: "Lunar", bonus: 4, color: "#96ca8c")
Continent.create(map: moon, name: "Cresinion", type: "Lunar", bonus: 2, color: "#f79063")
Continent.create(map: moon, name: "Delphot", type: "Lunar", bonus: 2, color: "#7073c0")

mars = Map.create(:name => "Mars")
Continent.create(map: mars, name: "Arcadia", type: "Land", bonus: 3, color: "#df9ce9")
Continent.create(map: mars, name: "Amazonis", type: "Land", bonus: 6, color: "#7e83de")
Continent.create(map: mars, name: "Tharsis", type: "Land", bonus: 3, color: "#f0e660")
Continent.create(map: mars, name: "Vulcan", type: "Land", bonus: 5, color: "#e76263")
Continent.create(map: mars, name: "Eden", type: "Land", bonus: 4, color: "#6df25b")
Continent.create(map: mars, name: "Casius", type: "Land", bonus: 5, color: "#6df25b")
Continent.create(map: mars, name: "Propontis", type: "Water", bonus: 2, color: "#8dd92f")
Continent.create(map: mars, name: "Acidalium", type: "Water", bonus: 3, color: "#f0fb71")
Continent.create(map: mars, name: "Arabia", type: "Water", bonus: 2, color: "#12bcf0")
Continent.create(map: mars, name: "Utopia", type: "Water", bonus: 2, color: "#e417ff")
Continent.create(map: mars, name: "Isidis", type: "Water", bonus: 1, color: "#e99127")

mars_moons = Map.create(:name => "Phobos & Deimos", :moon => true)
Continent.create(map: mars_moons, name: "Norseland", type: "Lunar", bonus: 3, color: "#f27f43")
Continent.create(map: mars_moons, name: "New America", type: "Lunar", bonus: 2, color: "#8ffd76")
Continent.create(map: mars_moons, name: "Federation", type: "Lunar", bonus: 3, color: "#dd81ee")

asteroids = Map.create(:name => "Asteroid Colonies", :moon => true)
Continent.create(map: asteroids, name: "1 Ceres", type: "Lunar", bonus: 4, color: "#e87386")
Continent.create(map: asteroids, name: "4 Vesta", type: "Lunar", bonus: 2, color: "#9aea89")
Continent.create(map: asteroids, name: "Dactyl", type: "Lunar", bonus: 1, color: "#80ccf1")
Continent.create(map: asteroids, name: "243 Ida", type: "Lunar", bonus: 2, color: "#f0f47b")

io = Map.create(:name => "Io")
Continent.create(map: io, name: "Narkom", type: "Land", bonus: 4, color: "#718cc1")
Continent.create(map: io, name: "Automin", type: "Land", bonus: 5, color: "#e35b5b")
Continent.create(map: io, name: "Skandi", type: "Land", bonus: 2, color: "#0e0e0e")
Continent.create(map: io, name: "Balt", type: "Land", bonus: 3, color: "#e2d66a")
Continent.create(map: io, name: "Ugricya", type: "Land", bonus: 5, color: "#78a07d")
Continent.create(map: io, name: "Hoenheim", type: "Land", bonus: 5, color: "#d087e0")
Continent.create(map: io, name: "Ecclesia", type: "Land", bonus: 2, color: "#9eddef")
Continent.create(map: io, name: "Ghaul", type: "Land", bonus: 4, color: "#aaf982")
Continent.create(map: io, name: "Granada", type: "Land", bonus: 2, color: "#bc8372")
Continent.create(map: io, name: "Mashriq", type: "Lava", bonus: 1, color: "#bfbfbf")
Continent.create(map: io, name: "Caprica", type: "Lava", bonus: 1, color: "#fd9415")
Continent.create(map: io, name: "Soter", type: "Lava", bonus: 1, color: "#2e2e2e")
Continent.create(map: io, name: "Khell", type: "Lava", bonus: 3, color: "#6bc2cb")
Continent.create(map: io, name: "Nuraghe", type: "Lava", bonus: 1, color: "#e10005")
Continent.create(map: io, name: "Magreb", type: "Lava", bonus: 3, color: "#4c0fb5")

europa = Map.create(:name => "Europa")
Continent.create(map: europa, name: "Angeln", type: "Land", bonus: 3, color: "#d896dd")
Continent.create(map: europa, name: "Galilei", type: "Land", bonus: 6, color: "#141414")
Continent.create(map: europa, name: "Seaxna", type: "Land", bonus: 3, color: "#e8df78")
Continent.create(map: europa, name: "Cymru", type: "Land", bonus: 4, color: "#b2ecf7")
Continent.create(map: europa, name: "Byfed", type: "Land", bonus: 2, color: "#a3f674")
Continent.create(map: europa, name: "Avalon", type: "Land", bonus: 3, color: "#ff777b")
Continent.create(map: europa, name: "SungTzu", type: "Water", bonus: 2, color: "#ee0613")

Faction.create(:name => "Default",
               :classification => "Default",
               :official => true,
               :starting_resources => "3 Energy\nLand Commander\nDiplomat Commander\n1 Space Station",
               :abilities => "None")

Faction.create(:name => "Primus Oceanus", 
               :classification => "Oceanographers", 
               :official => true,
               :starting_resources => "3 Energy\nLand Commander\nNaval Commander\n1 Space Station\n1 Random Naval Command Card", 
               :abilities => "Whenever you take a Water Command Card, draw 2 instead.  Choose 1 to keep and shuffle the other back into the deck.  (You can take Water Command Cards one at a time during the purchase phase.)")

Faction.create(:name => "Havoc", 
               :classification => "Nuclear Anarchists", 
               :official => true,
               :starting_resources => "1 Energy\nLand Commander\nNuclear Commander\n1 Space Station\n1 Random Nuclear Command Card", 
               :abilities => "At the start of each turn (Before placement of units).  Look at the top 3 Nuclear Command Cards from the Command Deck.  Choose 1 and play it for free.  Shuffle the other two back into the deck.")

Faction.create(:name => "Church of Him", 
               :classification => "Zealots", 
               :official => false,
               :starting_resources => "3 Energy\nLand Commander\nNuclear Commander\nTech Commander\n0 Space Stations\n3 Random Cards, One for each commander", 
               :abilities => "During invasion, the player win all tie.  But during defence, the player lose all ties.")

Faction.create(:name => "Free Militia", 
               :classification => "Warmongers", 
               :official => false,
               :starting_resources => "2 Energy\nAny 4 commanders\n0 Space Stations\n1 random card from any deck (must have the commander)", 
               :abilities => "Each turn, you receive one MOD for each commander you control (this MOD must be placed in the territory with the commander). You no longer receive fee MOD's from your Space Stations.  Commanders cost 2 energy.")

Faction.create(:name => "The Fusion Conservancy", 
               :classification => "Conservationists", 
               :official => true,
               :starting_resources => "6 Energy\nLand Commander\nTech Commander\n1 Space Station\n1 Random Tech Command Card", 
               :abilities => "Gain 20% (rounded up) Energy Bonus earch of your turns.")

Faction.create(:name => "Gayans", 
               :classification => "Recyclers", 
               :official => false,
               :starting_resources => "1 Energy\nNaval Commander\nSpace Commender\n2 Space Stations", 
               :abilities => "At any time you may discard your Command Cards to receive 1 energy each.")

Faction.create(:name => "MegaCorp", 
               :classification => "Industrialists", 
               :official => false,
               :starting_resources => "4 Energy\nLand Commander\n1 Spacd Station", 
               :abilities => "The player starts the game with a supplemental MOD for each player in the game.  During each turn the player deploys 20% (round up) more MOD's.")

Faction.create(:name => "Preservation", 
               :classification => "Survivalists", 
               :official => true,
               :starting_resources => "2 Energy\nLand Commander\nDiplomat Commander\n2 Space Stations\n1 Random Land Command Card", 
               :abilities => "Space Stations cost 3 Energy.  Place 2 MOD's on your space stations instead of 1 each turn.")

Faction.create(:name => "Republicanists", 
               :classification => "Bureaucrats", 
               :official => false,
               :starting_resources => "4 Energy\nLand Commander\nDiplomat Commander\n1 Space Station\n1 Random Diplomat or Land Card", 
               :abilities => "When the player bids for turn order add one.")

Faction.create(:name => "Silicon Knights", 
               :classification => "Technologists", 
               :official => true,
               :starting_resources => "4 Energy\nTech Commander\nLunar Commander\n1 Space Station\n1 Random Space Command Card", 
               :abilities => "When purchasing Command Cards, you may purchase up to 2 immediately playable cards each turn from any discard pile.  These cards must be immediately played.  Cards played in this manner are removed from the game.")

Faction.create(:name => "Tranquility", 
               :classification => "Humanitarians", 
               :official => true,
               :starting_resources => "3 Energy\nLand Commander\nDiplomat Commander\n1 Space Station\n1 Cease Fire Card (from deck)", 
               :abilities => "When purchasing Command Cards, Can gain 1 Diplomat Card per turn free (This additional card may exceed the 4 card per turn limit).")

Forum.create(name: "Questions & Answers")
Forum.create(name: "Command Cards")
Forum.create(name: "General")
Forum.create(name: "Strategies")
Forum.create(name: "Expansions")