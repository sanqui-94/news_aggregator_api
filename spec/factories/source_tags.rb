FactoryBot.define do
  factory :source_tag do
    association :source
    association :tag
  end
end
