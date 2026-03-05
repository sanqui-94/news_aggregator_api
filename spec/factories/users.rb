FactoryBot.define do
  factory :user do
    provider { "google" }
    sequence(:uid)   { |n| "uid_#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    name { "Test User" }
    role { "user" }

    trait :admin do
      role { "admin" }
    end
  end
end
