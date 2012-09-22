FactoryGirl.define do
  factory :game_player do
    player
    faction_id 0
    color { GamePlayer::COLORS.sample } 
    territory_count 12
    energy 4
    units 4
    created_at { Time.now }
    updated_at { Time.now }
  end
end
