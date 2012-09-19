FactoryGirl.define do
  factory :game do
    location "Chicago"
    number_of_years 5
    notes ""
    created_at { Time.now }
    updated_at { Time.now }
  end
end
