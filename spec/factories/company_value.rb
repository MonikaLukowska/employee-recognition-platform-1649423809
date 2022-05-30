FactoryBot.define do
  factory :company_value do
    sequence(:title) { |n| "Company Value Title#{n}" }
  end
end
