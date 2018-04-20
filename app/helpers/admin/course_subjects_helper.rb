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
    if current_user.admin?
      @link = admin_show_subject_course_path(course_id: params[:id], subject_id: @subject.id)
    elsif current_user.trainer?
      @link = trainer_course_subject_path(course_id: params[:id], subject_id: @subject.id)
    else
      @link = course_subject_path(course_id: params[:id], subject_id: @subject.id)
    end
  end

  def define_more_show_course_subject cs, subject, course
    if current_user.admin?
      @link_to_edit_subject = edit_admin_subject_path(subject)
      @link_to_course = admin_course_path(course)
    elsif current_user.trainer?
      @link_to_edit_subject = edit_admin_subject_path(subject)
      @link_to_course = course_path(course)
    else
      @link_to_edit_subject =edit_admin_subject_path(subject)
      @link_to_course = mycourse_path(course)
    end
    define_data_chart subject, course
  end

  def define_data_chart subject, course
    @data = course.course_user_lessons.of_lesson_ids(subject.lesson_ids).finish.chart_data
    course_users = course.course_users.trainees
    course_users.each do |course_user|
      exist = :false
      @data.each do |x|
        if course_user.id == x[0]
          x[0] = course_user.user.name.upcase
          exist = :true
        end
      end
      if exist == :false
        @data << [course_user.user.name.upcase, 0]
      end
    end
  end

  def define_path course
    case current_user.permission
      when "admin"
        admin_course_path course
      when "trainer"
        trainer_course_path course
      else
        mycourse_path course
      end
  end
end
