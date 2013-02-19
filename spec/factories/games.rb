FactoryGirl.define do
  factory :game do
    creator
    location "Chicago"
    number_of_years 5
    notes ""
    map_ids { Map.all.map(&:id).sample(2) }
    after(:build) do |game|
      2.times { |index| game.game_players.build(FactoryGirl.attributes_for(:game_player).merge(turn_order: (index + 1))) }
    end
    created_at { Time.now }
    updated_at { Time.now }
  end
end
