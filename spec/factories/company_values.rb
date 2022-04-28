FactoryBot.define do
  factory :company_value do
    sequence(:title) { |n| "Title#{n}" }
  end
end
