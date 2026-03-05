FactoryBot.define do
  factory :article do
    association :source
    sequence(:title)       { |n| "Article #{n}" }
    sequence(:url)         { |n| "https://example.com/article-#{n}" }
    sequence(:external_id) { |n| "guid-#{n}" }
    published_at           { 1.day.ago }
    summary                { "A test article summary" }
  end
end
