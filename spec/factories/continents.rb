FactoryGirl.define do
  factory :continent do
    name "North America"
    type "Land"
    bonus 5
    color "#eae74a"
    created_at { Time.now }
    updated_at { Time.now }
  end

  factory :land_continent, parent: :continent do
    type "Land"
  end

  factory :water_continent, parent: :continent do
    type "Water"
  end

  factory :lunar_continent, parent: :continent do
    type "Lunar"
  end

  factory :lava_continent, parent: :continent do
    type "Lava"
  end

end
