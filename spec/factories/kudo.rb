FactoryBot.define do
  factory :kudo do
    title { 'First kudo' }
    content { 'Nice work!' }
    association :giver, factory: :employee
    association :receiver, factory: :employee
    association :company_value
  end
end
