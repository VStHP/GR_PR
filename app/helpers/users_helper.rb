module UsersHelper
  def define_color_permission user
    case user.permission
    when "admin"
      "success"
    when "trainer"
      "primary"
    else
      "warning"
    end
  end

  def define_title_status user
    case user.status
    when "active"
      @title = "CLICK để khóa tài khoản"
      @i_class = "unlock"
      @a_class = "btn btn-xs btn-info"
    else
      @title = "CLICK để mở khóa tài khoản"
      @i_class = "lock"
      @a_class = "btn btn-xs btn-danger"
    end
  end

  def current_user_here? user
    user == current_user
  end

  def show_avatar_for user
    image_tag(user.avatar.url, class: "img-circle img-responsive avatar-size", id: "avatar_image")
  end

  def define_course_profile user
    @course_joins = user.courses_join
    @course_owners = user.courses
  end

  def link_course_profile course
    case
    when current_user.admin?
      admin_course_path(course)
    when current_user.trainer?
      course_path(course)
    else
      "#"
    end
  end
end
