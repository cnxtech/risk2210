FactoryBot.define do
  factory :forum do
    sequence(:name) { |n| "Forum #{n}" }
    description { Faker::Lorem.sentence }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
