FactoryBot.define do
  factory :game_player do
    player
    faction { Faction.random }
    color { GamePlayer::COLORS.sample }
    territory_count 12
    energy 4
    units 4
    space_stations 1
    handle { Faker::Name.first_name }
    turn_order { rand(5) + 1}
    colony_influence { rand(2) + 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
