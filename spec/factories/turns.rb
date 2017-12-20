FactoryBot.define do
  factory :turn do
    game
    game_player
    order 1
    year 3
    created_at { Time.now }
    updated_at { Time.now }
  end
end
