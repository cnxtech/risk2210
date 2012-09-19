FactoryGirl.define do
  factory :map do
    name "Earth"
    moon false
    created_at { Time.now }
    updated_at { Time.now }
  end
end
