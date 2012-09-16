FactoryGirl.define do
  factory :faction do
    name "Havoc"
    classification "Nuclear Anarchists"
    official true
    starting_resources "1 Energy\nLand Commander\nNuclear Commander\n1 Space Station\n1 Random Nuclear Command Card"
    abilities "At the start of each turn (Before placement of units).  Look at the top 3 Nuclear Command Cards from the Command Deck.  Choose 1 and play it for free.  Shuffle the other two back into the deck."
  end
end
