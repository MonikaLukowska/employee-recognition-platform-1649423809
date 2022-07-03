# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |i|
  Employee.where(email: 'employee#{i}@gmail.com').first_or_create!( password: "psswd123")
end

AdminUser.where(email:'admin@example.com').first_or_create!(password:'password')

['Honesty', 'Ownership', 'Accountability', 'Passion'].each { |val| CompanyValue.where(title: val ).first_or_create!}

5.times do |i|
  Kudo.where(title: "Kudo #{i} title", content: "Kudo content", receiver:Employee.first, giver:Employee.last, company_value: CompanyValue.all.sample).first_or_create!
end

1.upto(5) do |i|
  Reward.where(title: "Title #{i}", description: 'Reward description', price: i ).first_or_create!
end
