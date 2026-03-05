FactoryBot.define do
  factory :source do
    sequence(:name) { |n| "Source #{n}" }
    sequence(:url)  { |n| "https://example#{n}.com/feed.xml" }
    site_url        { "https://example.com" }
    description     { "A test RSS source" }
    active          { true }

    trait :inactive do
      active { false }
    end
  end
end
