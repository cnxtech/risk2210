FactoryBot.define do
  factory :comment do
    player
    association :commentable, factory: :topic
    body { Faker::Lorem.sentences }
    created_at { Time.now }
    updated_at { Time.now }
  end

  factory :topic_comment, parent: :comment do
    association :commentable, factory: :topic
  end

  factory :comment_comment, parent: :comment do
    association :commentable, factory: :topic_comment
  end

end
