# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
    provider "MyString"
    uid "MyString"
    first_name "MyString"
    last_name "MyString"
    email "MyString"
  end
end
