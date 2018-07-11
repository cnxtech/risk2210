FactoryBot.define do
  factory :topic do
    forum
    player
    subject "Subject"
    view_count 1
    comment_count 0
    last_comment_at nil
    created_at { Time.now }
    updated_at { Time.now }
  end
end
