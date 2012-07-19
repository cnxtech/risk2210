FactoryGirl.define do
  factory :player do
    provider "facebook"
    uid "123"
    handle "Nick"
    first_name "Nick"
    last_name "DeSteffen"
    email "nick.desteffen@gmail.com"
    password "secret1"
    password_confirmation "secret1"
    login_count 1
  end
end
