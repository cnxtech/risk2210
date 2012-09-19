FactoryGirl.define do
  factory :turn do
    game_player
    order 1
    units_collected 3
    energy_collected 3
    territories_held 12
    created_at { Time.now }
    updated_at { Time.now }
  end
end
