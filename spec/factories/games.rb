FactoryBot.define do
  factory :game do
    creator
    location "Chicago"
    number_of_years 5
    notes ""
    map_ids { Map.all.map(&:id).sample(2) }
    completed false
    current_year 1
    after(:build) do |game|
      game.game_players.build(attributes_for(:game_player).merge(turn_order: 1, handle: game.creator.handle))
      game.game_players.build(attributes_for(:game_player).merge(turn_order: 2))
    end
    created_at { Time.now }
    updated_at { Time.now }
  end
end
