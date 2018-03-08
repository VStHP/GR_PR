# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
1.upto(20) do |x|
  User.create!(name: "Admin num_#{x}", email: "adminnum_#{x}@gmail.com", password: "123123",
     password_confirmation: "123123", gender: 'male', birthday: "30/09/1996", phone: "01202467914",
     university: "DUY TAN UNIVERSITY",program: "Manage of IT stCompany Education", permission: 'admin')
  User.create!(name: "Duong Ngoc Tam num_#{x}", email: "ngoctam3096num_#{x}@gmail.com", password: "123123",
     password_confirmation: "123123", gender: 'female', birthday: "30/09/1996", phone: "01202467914",
     university: "DUY TAN UNIVERSITY",program: "Manage of IT stCompany Education", permission: 'trainer')
  User.create!(name: "Bui Duy Phuong num_#{x}", email: "duypuongnum_#{x}@gmail.com", password: "123123",
     password_confirmation: "123123", gender: 'male', birthday: "30/09/1996", phone: "01202467914",
     university: "DUY TAN UNIVERSITY",program: "Manage of IT stCompany Education", permission: 'trainee')
end
