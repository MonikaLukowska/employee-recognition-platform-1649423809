FactoryBot.define do
  factory :order do
    association :employee
    association :reward
    reward_snapshot { reward }
  end
end
