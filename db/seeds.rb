# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)

#Delete all database
  CourseSubject.delete_all
  CourseUser.delete_all
  Link.delete_all
  Task.delete_all
  Subject.delete_all
  Course.delete_all
  User.delete_all
#User database
  User.create!(name: "Admin: Ngọc Tâm", email: "admin@gmail.com", password: "123123",
       password_confirmation: "123123", gender: 'male', birthday: "30/09/1996", phone: "01202467914",
       university: "ĐH Duy Tân, Đà Nẵng",program: "Quản lý bộ phận phát triển nhân lực Công Ty IT stCompany", permission: 'admin')
  User.create!(name: "Trainer: Ngọc Sơn", email: "lengocson1996vn@gmail.com", password: "123123",
       password_confirmation: "123123", gender: 'male', birthday: "6/9/1996", phone: "01235451476",
       university: "ĐH Duy Tân, Đà Nẵng",program: "Quản lý bộ phận phát triển nhân lực Công Ty IT stCompany", permission: 'trainer')
  User.create!(name: "Bùi Duy Phương", email: "buiduyphuong95@gmail.com", password: "123123",
       password_confirmation: "123123", gender: 'male', birthday: "20/11/1995", phone: "01235451476",
       university: "ĐH Duy Tân, Đà Nẵng",program: "Thực tập nâng cao", permission: 'trainee')
  array_dh = [ 'ĐH Duy Tân','ĐH Bách Khoa Đà Nẵng', 'CĐ Công Nghệ', 'ĐH Kinh Tế Đà Nẵng', 'ĐH Sư Phạm Đà Nẵng' ]
  last_name = [ 'Dương', 'Nguyễn', 'Lê', 'Phạm', 'Trần', 'Phan' ]
  mid_name1 = [ '', 'Thị', '' ]
  mid_name2 = "Ngọc"
  first_name = [ 'Tú', 'Tình', 'Tâm', 'Phương', 'Hưng', 'Phúc', 'Đạt', 'Linh', 'Trang', 'Nguyên' ]
  arr_program = [ 'Trainer bộ phận phát triển nhân lực Công Ty IT stCompany', 'Thực tập lập trình website' ]
  1.upto(15) do |x|
    name = last_name.sample + ' ' + mid_name1.sample + ' ' + mid_name2 + ' ' +first_name.sample
    if name.include? "Thị" then gender = "female" else gender = "male" end
    dh = array_dh.sample
    mail = Faker::Internet.free_email
    password = "123123"
    birthday = Faker::Date.between(30.years.ago, 25.years.ago)
    phone = nil
    program = arr_program[0]
    User.create!(name: name, email: mail, password: password, password_confirmation: password, gender: gender,
      birthday: birthday, phone: phone, university: dh,program: program, permission: 'trainer')
  end
  1.upto(20) do |x|
    name = last_name.sample + ' ' + mid_name1.sample + ' ' + mid_name2 + ' ' +first_name.sample
    if name.include? "Thị" then gender = "female" else gender = "male" end
    dh = array_dh.sample
    mail = Faker::Internet.free_email
    password = "123123"
    birthday = Faker::Date.between(30.years.ago, 20.years.ago)
    phone = nil
    program = arr_program[1]
    User.create!(name: name, email: mail, password: password, password_confirmation: password, gender: gender,
      birthday: birthday, phone: phone, university: dh,program: program, permission: 'trainee')
  end

#Course database
  Course.create! id: "RB-B1-2018", name: "Thực tập lập trình Ruby on Rails khóa 1 - 2018", program: "Phát triển website",
    language: "Ruby", date_start: Faker::Date.forward(90), user_id: User.filter_by("trainer").sample.id
  Course.create! id: "PHP-B2-2018", name: "Thực tập lập trình Laravel khóa 2 - 2018", program: "Phát triển website",
    language: "PHP", date_start: Faker::Date.forward(90), user_id: User.filter_by("trainer").sample.id
  Course.create! id: "ANDROID-B3-2018", name: "Thực tập lập trình Android khóa 3 - 2018", program: "Phát triển ứng dụng di động",
    language: "Android", date_start: Faker::Date.forward(90), user_id: User.filter_by("trainer").sample.id
  Course.create! id: "RB-B4-2018", name: "Thực tập lập trình Ruby on Rails khóa 4 - 2018", program: "Phát triển website",
    language: "Ruby", date_start: Faker::Date.forward(90), user_id: User.filter_by("trainer").sample.id

#Subejct database
  Subject.create! id: "GIT-BASE", name: "Sử dụng Git cơ bản trong công việc", day_on_learn: 4, description: "Some detail about git and github"
  Subject.create! id: "GIT-ADV", name: "Git nâng cao và quản lý source code trên Github", day_on_learn: 2, description: "Some detail about git and github"
  Subject.create! id: "RUBY-T1", name: "Lập trình với ngôn ngữ Ruby", day_on_learn: 5, description: "Some detail about ruby"
  Subject.create! id: "RUBY-T2", name: "Ruby nâng cao trong lập trình", day_on_learn: 4, description: "Some detail about ruby"
  Subject.create! id: "RAILS-T1", name: "Lập trình web bằng framwork Ruby on Rails", day_on_learn: 12, description: "Some detail about rails"
  Subject.create! id: "PHP-T1", name: "Lập trình với ngôn ngữ PHP", day_on_learn: 5, description: "Some detail about php"
  Subject.create! id: "LARAVEL-T1", name: "Lập trình web bằng framwork Laravel", day_on_learn: 12, description: "Some detail about Laravel"
