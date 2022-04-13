FactoryBot.define do
  factory :employee do
    sequence(:email) { |n| "testy#{n}@example.com" }
    password { 'password123' }
  end
end
