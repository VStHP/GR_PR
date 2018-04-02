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

  def warning_edit_class subject
    "has-warning" if subject.course_subjects.present?
  end

  def warning_edit_message subject
    "Lưu ý: Môn học đã được thêm vào các khóa học, hãy cẩn thận khi chỉnh sửa!" if subject.course_subjects.present?
  end
end
