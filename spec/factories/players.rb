FactoryGirl.define do
  factory :base_player, class: "Player" do
    handle { Faker::Name.first_name }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    login_count 2
    last_login_at { 1.week.ago }
    public_profile true
    favorite_color { GamePlayer::COLORS.sample }
    image_source nil
    facebook_image_url nil
    provider nil
    uid nil
    city "Chicago"
    state "IL"
    zip_code "60640"
    bio { Faker::Lorem::sentence }
    website nil
    gravatar_hash nil
    raw_authorization nil
    password_reset_token nil
    created_at { Time.now }
    updated_at { Time.now }
  end

  factory :player, parent: :base_player, aliases: [:creator] do
    password "secret1"
    password_confirmation "secret1"
  end
  factory :facebook_player, parent: :base_player do
    provider "facebook"
    uid "652508698"
  end

end
