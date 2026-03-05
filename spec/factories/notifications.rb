FactoryBot.define do
  factory :notification do
    association :user
    type  { "Notification" }
    read  { false }
    data  { { message: "Test notification" } }
  end
end
