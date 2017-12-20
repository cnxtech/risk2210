FactoryBot.define do
  factory :message do
    association :recipient, factory: :player
    association :sender, factory: :player
    subject { Faker::Lorem::sentence }
    body { Faker::Lorem.sentences.join(". ") }
  end
end
