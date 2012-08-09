FactoryGirl.define do
  factory :base_player, class: "Player" do
    handle { Faker::Name.first_name }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    login_count 2
    last_login_at { 1.week.ago }
    public_profile true
    created_at { Time.now }
    updated_at { Time.now }
  end
  
  factory :player, parent: :base_player do
    password "secret1"
    password_confirmation "secret1"
  end
  factory :facebook_player, parent: :base_player do
    provider "facebook"
    uid "652508698"
  end

end
