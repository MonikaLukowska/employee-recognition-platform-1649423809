# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |i|
  Employee.where(email: "employee#{i}@gmail.com").first_or_create!(password: 'psswd123')
end

AdminUser.where(email: 'admin@example.com').first_or_create!(password: 'password')

%w[Honesty Ownership Accountability Passion].each { |val| CompanyValue.where(title: val).first_or_create! }

employees = Employee.all

employees.each_with_index do |employee, i|
  3.times do
    Kudo.where(
      title: "Kudo #{i} title",
      content: 'Kudo content',
      receiver: employee,
      giver: employees[([*0..4] - [i]).sample],
      company_value: CompanyValue.all.sample
    ).first_or_create!
  end
end

1.upto(5) do |i|
  Reward.where(title: "Title #{i}", description: 'Reward description', price: 1).first_or_create!
end

rewards = Reward.all

employees.each do |employee|
  3.times do
    reward = rewards.sample
    Order.create!(
      employee: employee, reward: reward, reward_snapshot: reward
    )
  end
end
