FactoryBot.define do
  factory :kudo do
    title { 'First kudo' }
    content { 'Nice work!' }
    association :receiver, factory: :employee
    association :giver, factory: :employee
  end
end
