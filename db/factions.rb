Faction.find_or_create_by(:name => "Default",
               :classification => "Default",
               :official => true,
               :starting_resources => "3 Energy\nLand Commander\nDiplomat Commander\n1 Space Station",
               :abilities => "None")

Faction.find_or_create_by(:name => "Primus Oceanus", 
               :classification => "Oceanographers", 
               :official => true,
               :starting_resources => "3 Energy\nLand Commander\nNaval Commander\n1 Space Station\n1 Random Naval Command Card", 
               :abilities => "Whenever you take a Water Command Card, draw 2 instead.  Choose 1 to keep and shuffle the other back into the deck.  (You can take Water Command Cards one at a time during the purchase phase.)")

Faction.find_or_create_by(:name => "Havoc", 
               :classification => "Nuclear Anarchists", 
               :official => true,
               :starting_resources => "1 Energy\nLand Commander\nNuclear Commander\n1 Space Station\n1 Random Nuclear Command Card", 
               :abilities => "At the start of each turn (Before placement of units).  Look at the top 3 Nuclear Command Cards from the Command Deck.  Choose 1 and play it for free.  Shuffle the other two back into the deck.")

Faction.find_or_create_by(:name => "Church of Him", 
               :classification => "Zealots", 
               :official => false,
               :starting_resources => "3 Energy\nLand Commander\nNuclear Commander\nTech Commander\n0 Space Stations\n3 Random Cards, One for each commander", 
               :abilities => "During invasion, the player win all tie.  But during defence, the player lose all ties.")

Faction.find_or_create_by(:name => "Free Militia", 
               :classification => "Warmongers", 
               :official => false,
               :starting_resources => "2 Energy\nAny 4 commanders\n0 Space Stations\n1 random card from any deck (must have the commander)", 
               :abilities => "Each turn, you receive one MOD for each commander you control (this MOD must be placed in the territory with the commander). You no longer receive fee MOD's from your Space Stations.  Commanders cost 2 energy.")

Faction.find_or_create_by(:name => "The Fusion Conservancy", 
               :classification => "Conservationists", 
               :official => true,
               :starting_resources => "6 Energy\nLand Commander\nTech Commander\n1 Space Station\n1 Random Tech Command Card", 
               :abilities => "Gain 20% (rounded up) Energy Bonus earch of your turns.")

Faction.find_or_create_by(:name => "Gayans", 
               :classification => "Recyclers", 
               :official => false,
               :starting_resources => "1 Energy\nNaval Commander\nSpace Commender\n2 Space Stations", 
               :abilities => "At any time you may discard your Command Cards to receive 1 energy each.")

Faction.find_or_create_by(:name => "MegaCorp", 
               :classification => "Industrialists", 
               :official => false,
               :starting_resources => "4 Energy\nLand Commander\n1 Spacd Station", 
               :abilities => "The player starts the game with a supplemental MOD for each player in the game.  During each turn the player deploys 20% (round up) more MOD's.")

Faction.find_or_create_by(:name => "Preservation", 
               :classification => "Survivalists", 
               :official => true,
               :starting_resources => "2 Energy\nLand Commander\nDiplomat Commander\n2 Space Stations\n1 Random Land Command Card", 
               :abilities => "Space Stations cost 3 Energy.  Place 2 MOD's on your space stations instead of 1 each turn.")

Faction.find_or_create_by(:name => "Republicanists", 
               :classification => "Bureaucrats", 
               :official => false,
               :starting_resources => "4 Energy\nLand Commander\nDiplomat Commander\n1 Space Station\n1 Random Diplomat or Land Card", 
               :abilities => "When the player bids for turn order add one.")

Faction.find_or_create_by(:name => "Silicon Knights", 
               :classification => "Technologists", 
               :official => true,
               :starting_resources => "4 Energy\nTech Commander\nLunar Commander\n1 Space Station\n1 Random Space Command Card", 
               :abilities => "When purchasing Command Cards, you may purchase up to 2 immediately playable cards each turn from any discard pile.  These cards must be immediately played.  Cards played in this manner are removed from the game.")

Faction.find_or_create_by(:name => "Tranquility", 
               :classification => "Humanitarians", 
               :official => true,
               :starting_resources => "3 Energy\nLand Commander\nDiplomat Commander\n1 Space Station\n1 Cease Fire Card (from deck)", 
               :abilities => "When purchasing Command Cards, Can gain 1 Diplomat Card per turn free (This additional card may exceed the 4 card per turn limit).")
