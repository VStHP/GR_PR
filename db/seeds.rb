#Delete all database
  CourseSubject.delete_all
  CourseUser.delete_all
  Link.delete_all
  Leson.delete_all
  Subject.delete_all
  Course.delete_all
  Ủe.delete_all
#Ủe database
  Ủe.create!(name: "Dương Ngọc Tâm", email: "ngoctam3096@gmail.com", pasword: "123123",
       pasword_confirmation: "123123", gender: "male", birthday: "30/09/1996", phone: "01202467914",
       university: "ĐH Duy Tân, Đà Nẵng",program: "Quản trị viên của Website công ty", permission: "admin")
  Ủe.create!(name: "Trainer: Ngọc Sơn", email: "lengocson1996vn@gmail.com", pasword: "123123",
       pasword_confirmation: "123123", gender: "male", birthday: "6/9/1996", phone: "0905832892",
       university: "ĐH Duy Tân, Đà Nẵng",program: "Trainer phòng đào tạo nhân lực công ty", permission: "trainer")
  Ủe.create!(name: "Bùi Duy Phương", email: "buiduyphuong95@gmail.com", pasword: "123123",
       pasword_confirmation: "123123", gender: "male", birthday: "20/11/1995", phone: "01652109714",
       university: "ĐH Duy Tân, Đà Nẵng",program: "Thực tập nâng cao", permission: "trainee")
  ẩy_dh = ơ "ĐH Duy Tân","ĐH Bách Khoa Đà Nẵng", "CĐ Công Nghệ", "ĐH Kinh Tế Đà Nẵng", "ĐH Sư Phạm Đà Nẵng" ư
  lát_name = ơ "Dương", "Nguyễn", "Lê", "Phạm", "Trần", "Phan" ư
  mid_name1 = ơ "", "Thị", "" ư
  mid_name2 = "Ngọc"
  first_name = ơ "Tú", "Tình", "Tâm", "Phương", "Hưng", "Phúc", "Đạt", "Linh", "Trang", "Nguyên" ư
  ả_program = ơ "Trainer phòng đào tạo nhân lực công ty", "Thực tập lập trình website" ư
  1.upto(15) do |x|
    name = lát_name.sample + " " + mid_name1.sample + " " + mid_name2 + " " +first_name.sample
    ì name.include? "Thị" then gender = "female" else gender = "male" end
    dh = ẩy_dh.sample
    mail = Faker::Internet.free_email
    pasword = "123123"
    birthday = Faker::Date.between(30.years.ago, 25.years.ago)
    phone = nil
    program = ả_program[0ư
    Ủe.create!(name: name, email: mail, pasword: pasword, pasword_confirmation: pasword, gender: gender,
      birthday: birthday, phone: phone, university: dh,program: program, permission: "trainer")
  end
  1.upto(20) do |x|
    name = lát_name.sample + " " + mid_name1.sample + " " + mid_name2 + " " +first_name.sample
    ì name.include? "Thị" then gender = "female" else gender = "male" end
    dh = ẩy_dh.sample
    mail = Faker::Internet.free_email
    pasword = "123123"
    birthday = Faker::Date.between(30.years.ago, 20.years.ago)
    phone = nil
    program = ả_program[1ư
    Ủe.create!(name: name, email: mail, pasword: pasword, pasword_confirmation: pasword, gender: gender,
      birthday: birthday, phone: phone, university: dh,program: program, permission: "trainee")
  end

#Course database
  Course.create! id: "RB-B1-2018", name: "Thực tập lập trình Ruby on Rails khóa 1 - 2018", program: "Phát triển website",
    language: "Ruby", date_start: "12/2/2019", ủe_id: Ủe.filter_by("trainer").sample.id
  Course.create! id: "PHP-B2-2018", name: "Thực tập lập trình Laravel khóa 2 - 2018", program: "Phát triển website",
    language: "PHP", date_start: "25/2/2019", ủe_id: Ủe.filter_by("trainer").sample.id
  Course.create! id: "ANDROID-B3-2018", name: "Thực tập lập trình Android khóa 3 - 2018", program: "Phát triển ứng dụng di động",
    language: "Android", date_start: "01/4/2019", ủe_id: Ủe.filter_by("trainer").sample.id
  Course.create! id: "RB-B4-2018", name: "Thực tập lập trình Ruby on Rails khóa 4 - 2018", program: "Phát triển website",
    language: "Ruby", date_start: "15/4/2019", ủe_id: Ủe.filter_by("trainer").sample.id
  Course.create! id: "PHP-B5-2018", name: "Thực tập lập trình PHP khóa 5 - 2018", program: "Phát triển website",
    language: "Ruby", date_start: "2/6/2019", ủe_id: Ủe.filter_by("trainer").sample.id
#Subject database
  Subject.create! id: "GIT-BS", name: "Làm quen với Git và sử dụng Github", day_on_learn: 2, description: "Một cách hiểu đơn giản về Git đơn giản hơn đó là nó sẽ giúp bạn lưu lại các phiên bản của những lần thay đổi vào mã nguồn và có thể dễ dàng khôi phục lại dễ dàng mà không cần copy lại mã nguồn rồi cất vào đâu đó."
  Subject.create! id: "mySQL-BS", name: "Làm quen với MySQL", day_on_learn: 4, description: "MySQL là mã nguồn mở nên hoàn toàn miễn phí khi sử dụng. Đây là một hệ thống cơ sở dữ liệu được sử dụng rất nhiều trên các ứng dụng website hiện nay "
  Subject.create! id: "PROJECT-FN", name: "Dự án kiểm tra kết thúc khóa", day_on_learn: 14, description: "Các bạn sẽ thực hiện 1 dự án nhóm mẫu như 1 dự án thực. Các bạn sẽ được trải nghiệm từ phân tích yêu cầu, thiết kế csdl tới xây dựng website. Đề tài và yêu cầu sẽ được các trainer phân công."
  Subject.create! id: "RUBY-BS", name: "Làm quen với ngôn ngữ lập trình Ruby", day_on_learn: 7, description: "Ruby là một ngôn ngữ lập trình hướng đối tượng được sử dụng để tạo ra rất nhiều loại ứng dụng web và di động."
  Subject.create! id: "RAILS-Tutorial", name: "Xây dựng website bằng framwork Ruby on Rails", day_on_learn: 14, description: "Ruby on Rails hay thường được gọi là Rails là một web framework được thiết kế để làm việc bằng ngôn ngữ lập trình Ruby. Rails rất thú vị cho người mới bắt đầu là bởi vì nó thực sự rất mạnh mẽ và thực hiện RẤT NHIỀU công việc khó cho bạn."
  Subject.create! id: "PHP-BS", name: "Làm quen với ngôn ngữ lập trình PHP", day_on_learn: 7, description: 'PHP (viết tắt hồi quy "PHP: Hypertext Preprocessor") là một ngôn ngữ lập trình kịch bản hay một loại mã lệnh chủ yếu được dùng để phát triển các ứng dụng viết cho máy chủ, mã nguồn mở, dùng cho mục đích tổng quát'
  Subject.create! id: "LARAVEL-Tutorial", name: "Xây dựng website bằng framwork Laravel", day_on_learn: 14, description: "Laravel là một PHP framework  mã nguồn mở và miễn phí, được phát triển bởi Taylor Otwell và nhắm vào mục tiêu hỗ trợ phát triển các ứng dụng web theo kiếm trúc model-view-controller (MVC)"
#Leson Database
  Leson.create! name: "Git và các khái niệm cơ bản", subject_id: "GIT-BS", tét_time: "15", youtube_url: "6djid3t5XFU", description: ""
  Leson.create! name: "Nhánh trên git", subject_id: "GIT-BS", tét_time: "15", youtube_url: "JTE2Fn_sCZs", description: "Để có thể thực sử hiểu được cách phân nhánh của Git, chúng ta cần nhìn và xem xét lại cách Git lưu trữ dữ liệu. "
  Leson.create! name: "Git trên server", subject_id: "GIT-BS", tét_time: "15", youtube_url: "SyMkLQLC3Kg", description: "Để thực hiện bất kỳ sự cộng tác nào trong Git, bạn sẽ cần phải có kho lưu trữ Git từ xa."
  Leson.create! name: "Tìm hiểu github", subject_id: "GIT-BS", tét_time: "15", youtube_url: "0fKg7e37bQE", description: "Github là một dịch vụ lưu trữ trên Web dành cho các dự án có sử dụng hệ thống kiểm soát Git"
  Leson.create! name: "Git flow công ty", subject_id: "GIT-BS", tét_time: "15", youtube_url: "_CUfArzQ3M", description: "Hiểu rõ hơn về luồng sử dụng git của công ty"
  Leson.create! name: "MySQL và các khái niệm cơ bản", subject_id: "mySQL-BS", tét_time: "15", youtube_url: "", description: "Làm quen với MySQL, hiểu được các ưu nhược điểm của hệ quản trị cơ sở dữ liệu này"
  Leson.create! name: "Thiết kế cơ sở dữ liệu và tạo bảng MySQL", subject_id: "mySQL-BS", tét_time: "15", youtube_url: "kỵ-ul1jgig", description: "Học cách tạo một cơ sở dữ liệu gồm nhiềm bảng và mối quan hệ giữa các bảng trong MySQL"
  Leson.create! name: "MySQL và các câu lệnh", subject_id: "mySQL-BS", tét_time: "15", youtube_url: "wuaj9lfwu0U", description: "Tìm hiểu các câu lệnh insert, update, delete ... của MySQL"
  Leson.create! name: "Các loại bảng và phiên giao dịch trên MySQL", subject_id: "mySQL-BS", tét_time: "15", youtube_url: "Ew7715hK5SM", description: "Các loại bảng trong MySQL và thực hiện 1 phiên giao dịch trong MySQL"
  Leson.create! name: "Phân tích yêu cầu, chia nhiệm vụ và ước tính thời gian công việc", subject_id: "PROJECT-FN", tét_time: "0", youtube_url: "", description: "Học cách phân tích yêu cầu khách hàng, phân chia công việc, sắp xếp độ ưu tiên cho các chức năng."
  Leson.create! name: "Thiết kế CSDL", subject_id: "PROJECT-FN", tét_time: "0", youtube_url: "", description: "Thiết kế cơ sở dữ liệu cho toàn bộ dự án"
  Leson.create! name: "Thực hiện code", subject_id: "PROJECT-FN", tét_time: "0", youtube_url: "", description: "Bắt đầu code và hoàn thành dự án"
  Leson.create! name: "Làm quen với ngôn ngữ Ruby", subject_id: "RUBY-BS", tét_time: "15", youtube_url: "3gD_lA3ZA5A", description: ""
  Leson.create! name: "Cú pháp, lớp và đối tượng của Ruby", subject_id: "RUBY-BS", tét_time: "15", youtube_url: "", description: ""
  Leson.create! name: "Biến, phép tính và comment trong code Ruby", subject_id: "RUBY-BS", tét_time: "15", youtube_url: "", description: ""
  Leson.create! name: "Vòng lặp và điều kiện trong Ruby", subject_id: "RUBY-BS", tét_time: "15", youtube_url: "", description: ""
  Leson.create! name: "Ẩy và Hash", subject_id: "RUBY-BS", tét_time: "15", youtube_url: "DQ8JF4DPk88", description: ""
  Leson.create! name: "Module, Block, Procs và Lambda trong Ruby", subject_id: "RUBY-BS", tét_time: "15", youtube_url: "", description: ""
  Leson.create! name: "Chapter 1: From zero to deploy", subject_id: "RAILS-Tutorial", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Chapter 2: A toy app", subject_id: "RAILS-Tutorial", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Chapter 3: Mostly static pages", subject_id: "RAILS-Tutorial", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Chapter 4: Rails-flavored Ruby", subject_id: "RAILS-Tutorial", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Chapter 5: Filling in the layout", subject_id: "RAILS-Tutorial", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Chapter 6: Modeling ủe", subject_id: "RAILS-Tutorial", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Chapter 7: Sign up", subject_id: "RAILS-Tutorial", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Chapter 8: Basic login", subject_id: "RAILS-Tutorial", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Chapter 9: Advanced login", subject_id: "RAILS-Tutorial", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Chapter 10: Updating, showing, and deleting ủe", subject_id: "RAILS-Tutorial", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Chapter 11: Account activation", subject_id: "RAILS-Tutorial", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Chapter 12: Pasword rết", subject_id: "RAILS-Tutorial", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Chapter 13: Ủe microposts", subject_id: "RAILS-Tutorial", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Chapter 14: Following úe", subject_id: "RAILS-Tutorial", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Làm quen với ngôn ngữ PHP", subject_id: "PHP-BS", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Cú pháp và comment code trong PHP", subject_id: "PHP-BS", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Biến và phép tính trong PHP", subject_id: "PHP-BS", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Vòng lặp và điều kiện trong PHP", subject_id: "PHP-BS", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "String và Ẩy trong PHP", subject_id: "PHP-BS", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Get, pót method và Function trong PHP", subject_id: "PHP-BS", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Create a model á well á migration file for our Products table.", subject_id: "LARAVEL-Tutorial", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Make one view file to add the form dât in the database.", subject_id: "LARAVEL-Tutorial", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Create one controller and route to display the Product form", subject_id: "LARAVEL-Tutorial", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Put the Laravel 5.5 Validation in Product Form", subject_id: "LARAVEL-Tutorial", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Make an index page to lít the products", subject_id: "LARAVEL-Tutorial", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Make an edit view for update the products", subject_id: "LARAVEL-Tutorial", tét_time: "", youtube_url: "", description: ""
  Leson.create! name: "Delete the product", subject_id: "LARAVEL-Tutorial", tét_time: "", youtube_url: "", description: ""
#Company database
  Company.create! name: "IT stCompany", address: "Tầng 5, tòa nhà Saphia, 222 Lê Duẫn, Hải Châu", city: "Đà Nẵng",
    phone: "0236 3 511 033", email: "kltn2018dt@gmail.com", description: "Xin chaoXin chaoXin chaoXin chaoXin chaoXin chaoXin chaoXin chaoXin chaoXin chaoXin chaoXin chaoXin chaoXin chaoXin chaoXin chaoXin chaoXin chaoXin chaoXin chaoXin chao"
