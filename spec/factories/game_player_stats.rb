FactoryGirl.define do
  factory :game_player_stat do
    turn
    game_player
    units 12
    energy 12
    territory_count 20
    space_stations 1
    created_at { Time.now }
    updated_at { Time.now }
  end
end
