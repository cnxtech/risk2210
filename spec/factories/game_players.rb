FactoryGirl.define do
  factory :game_player do
    player
    faction { Faction.random }
    color { GamePlayer::COLORS.sample }
    territory_count 12
    energy 4
    units 4
    handle { Faker::Name.first_name }
    starting_turn_position { rand(5) + 1}
    created_at { Time.now }
    updated_at { Time.now }
  end
end
