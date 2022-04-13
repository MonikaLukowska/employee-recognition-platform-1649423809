FactoryBot.define do
  factory :kudo do
    title { 'First kudo' }
    content { 'Nice work!' }
    association :giver, factory: :employee
    receiver { giver }
  end
end
