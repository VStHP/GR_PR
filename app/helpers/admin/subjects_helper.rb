module Admin::SubjectsHelper
  def define_color_status_subject sb
    case sb.status
    when "active"
      @class = "info"
      @icon = "unlock"
      @title = "CLICK để khóa khóa học"
    else
      @color = "danger"
      @class = "danger"
      @icon = "lock"
      @title = "CLICK để mở khóa học"
    end
  end
end
