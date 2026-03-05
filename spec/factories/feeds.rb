FactoryBot.define do
  factory :feed do
    association :user
    sequence(:name) { |n| "Feed #{n}" }
  end
end
