# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |i|
  Employee.create(email: "employee#{i}@gmail.com", password: "psswd123")
end

AdminUser.create(email:"admin@example.com", password:'password')

['Honesty', 'Ownership', 'Accountability', 'Passion'].each { |val| CompanyValue.create(title: val )}

5.times do |i|
  Kudo.create(title: "Kudo #{i} title", content: "Kudo content", receiver:Employee.find(1), giver:Employee.find(2), company_value:CompanyValue.find(rand(4)))
end

