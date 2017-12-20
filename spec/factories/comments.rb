FactoryBot.define do
  factory :base_comment, class: Comment do
    player
    body { Faker::Lorem.sentences }
    created_at { Time.now }
    updated_at { Time.now }
  end

  factory :topic_comment, parent: :base_comment do
    association :commentable, factory: :topic
  end

  factory :comment_comment, parent: :base_comment do
    association :commentable, factory: :topic_comment
  end

end
