FactoryBot.define do
  factory :reward do
    sequence(:title) { |n| "Reward title#{n}" }
    association :category
    description { 'Description' }
    price { 1 }
  end
end
