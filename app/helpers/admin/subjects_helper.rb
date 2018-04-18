module Admin::SubjectsHelper
  def define_color_status_subject sb
    case sb.status
    when "active"
      @color ="default"
      @class = "info"
      @icon = "unlock"
      @title = "CLICK để khóa khóa thực tập"
    else
      @color = "danger"
      @class = "danger"
      @icon = "lock"
      @title = "CLICK để mở khóa thực tập"
    end
  end

  def warning_edit_class subject
    "has-warning" if subject.course_subjects.present?
  end

  def warning_edit_message subject
    "Lưu ý: Môn học đã được thêm vào các khóa thực tập, hãy cẩn thận khi chỉnh sửa!" if subject.course_subjects.present?
  end
end
