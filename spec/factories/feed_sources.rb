FactoryBot.define do
  factory :feed_source do
    association :feed
    association :source
  end
end
