module Admin::CourseSubjectsHelper
  def define_from_course_subject cs
    @subject = cs.subject
    @style_start = "display: none;"
    @style_end = "display: none;"
    if cs.date_start.present?
      @label_start = cs.date_start.to_date
      @style_start = nil
    end
    if cs.date_end.present?
      @label_end = cs.date_end.to_date
      @style_end = nil
    end
    case cs.status
    when "init"
      @next_status = "in_progress"
      @class_status = "btn btn-xs btn-primary"
      @icon_status = "fa fa-play"
      @text = " Bắt đầu"
    when "in_progress"
      @next_status = "finish"
      @class_status = "btn btn-xs btn-success"
      @icon_status = "fa fa-check"
      @text = " Kết thúc"
    end
  end
end
