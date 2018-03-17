module Admin::CoursesHelper
  def define_color_status_course course
    @class = "info"
    @icon = "unlock"
    @title = "CLICK để khóa khóa học"
    case course.status
    when "init"
      @color = "info"
    when "in_progress"
      @color = "warning"
    when "finish"
      @color = "success"
    else
      @color = "danger"
      @class = "danger"
      @icon = "lock"
      @title = "CLICK để mở khóa học"
    end
  end
end
