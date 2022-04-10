# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 5.times do |i|
#   Employee.create(email: "employee#{i}@gmail.com", password: "psswd123")
#  end

5.times do 
  Kudo.create(title: "dummy kudo", content: "some content", receiver_id:rand(1..6), giver_id:rand(1..6))
end