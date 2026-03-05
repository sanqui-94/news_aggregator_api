FactoryBot.define do
  factory :source_suggestion do
    association :user
    sequence(:url) { |n| "https://example#{n}.com/feed.xml" }
    description    { "A" * 50 }
    status         { "pending" }

    trait :approved do
      status { "approved" }
    end

    trait :rejected do
      status { "rejected" }
    end
  end
end
