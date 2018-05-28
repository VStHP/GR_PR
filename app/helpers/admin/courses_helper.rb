module Admin::CoursesHelper
  def define_color_status_course course
    @class = "info"
    @icon = "unlock"
    @title = "CLICK để khóa khóa thực tập"
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
      @title = "CLICK để mở khóa thực tập"
    end
  end

  def warning_edit_class_course course
    "has-warning" unless course.init?
  end

  def warning_edit_message_course course
    "Lưu ý: khóa thực tập đã được kích hoạt, hãy cẩn thận khi chỉnh sửa!" unless course.init?
  end

  def define_time_course subject
    time = 0
    subject.each {|s| time = time + s[:day_on_learn] }
    time
  end
end
