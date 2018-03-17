# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
User.delete_all
User.create!(name: "Admin", email: "admin@gmail.com", password: "123123",
     password_confirmation: "123123", gender: 'male', birthday: "30/09/1996", phone: "01202467914",
     university: "DUY TAN UNIVERSITY",program: "Manage of IT stCompany Education", permission: 'admin')
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

Course.delete_all
Course.create! id: "RB-B1-2018", name: "Thực tập lập trình Ruby on Rails khóa 1 - 2018", program: "Thực tập Web",
  language: "Ruby", date_start: "20/3/2018", user_id: User.filter_by("trainer")[0].id
Course.create! id: "PHP-B2-2018", name: "Thực tập lập trình Laravel khóa 2 - 2018", program: "Thực tập Web",
  language: "PHP", date_start: "20/5/2018", user_id: User.filter_by("trainer")[1].id
Course.create! id: "ANDROID-B3-2018", name: "Thực tập lập trình Android khóa 3 - 2018", program: "Thực tập Application",
  language: "Android", date_start: "20/7/2018", user_id: User.filter_by("trainer")[2].id
Course.create! id: "RB-B4-2018", name: "Thực tập lập trình Ruby on Rails khóa 4 - 2018", program: "Thực tập Web",
  language: "Ruby", date_start: "20/8/2018", user_id: User.filter_by("trainer")[3].id


Subject.delete_all
Subject.create! id: "GIT-BASE", name: "Sử dụng Git cơ bản trong công việc", day_on_learn: 4, description: "Some detail about git and github"
Subject.create! id: "GIT-ADV", name: "Git nâng cao và quản lý source code trên Github", day_on_learn: 2, description: "Some detail about git and github"
Subject.create! id: "RUBY-T1", name: "Lập trình với ngôn ngữ Ruby", day_on_learn: 5, description: "Some detail about ruby"
Subject.create! id: "RUBY-T2", name: "Ruby nâng cao trong lập trình", day_on_learn: 4, description: "Some detail about ruby"
Subject.create! id: "RAILS-T1", name: "Lập trình web bằng framwork Ruby on Rails", day_on_learn: 12, description: "Some detail about rails"
Subject.create! id: "PHP-T1", name: "Lập trình với ngôn ngữ PHP", day_on_learn: 5, description: "Some detail about php"
Subject.create! id: "LARAVEL-T1", name: "Lập trình web bằng framwork Laravel", day_on_learn: 12, description: "Some detail about Laravel"
