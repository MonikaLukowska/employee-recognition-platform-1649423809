FactoryBot.define do
  factory :category do
    sequence(:title) { |n| "Category Title#{n}" }
  end
end
