FactoryGirl.define do
  sequence :name do |n|
    "Forum #{n}"
  end
end

FactoryGirl.define do
  factory :forum do
    name
    description { Faker::Lorem.sentence }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
