module ApplicationHelper
  def full_title page_title = ""
    base_title = "Hệ thống quản lý khóa thực tập trực tuyến"
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def show_errors object, name_attribute, name_error
    messages = object.errors.messages[name_attribute]
    return "#{messages[0]}" if messages.present?
  end

  def check_errors object, name_attribute
    "has-error" if object.errors.messages[name_attribute].present?
  end

  def define_more_link_sidebar
    if current_user.trainer?
      @link_courses = trainer_courses_path
  #     @link_to_subjects = admin_subjects_path
  #     @link_to_new_subject = new_admin_subject_path
    else
      @link_courses = mycourses_path
  #     @link_to_subjects = trainer_subjects_path
  #     @link_to_new_subject = new_trainer_subject_path
    end
  end

  def define_course_user_lesson lesson, course_id
    @course_user_lesson = current_user.course_users.find_by(course_id: course_id).course_user_lessons.of_lesson(lesson)[0]
    case @course_user_lesson.status
    when "init"
      @cll = ""
      @url = report_progress_path(id: @course_user_lesson.id, status: "in_progress")
      @class = "btn btn-xs btn-info"
      @tt = "Nhấn để nhận chương"
      @icon = "fa fa-play"
      @text = " Bắt đầu"
    when "in_progress"
      @cll = "lesson-active"
      @url = report_progress_path(id: @course_user_lesson.id, status: "finish")
      @class = "btn btn-xs btn-danger"
      @tt = "Nhấn để kết thúc chương"
      @icon = "fa fa-flag"
      @text = " Kết thúc"
    when "finish"
      @cll = "lesson-finish"
      @url = "#"
      @class = "btn btn-xs btn-success"
      @tt = "Hoàn thành!"
      @icon = "fa fa-check"
      @text = ""
    else
      @cll = "lesson-finish"
      @url = "#"
      @class = "btn btn-xs btn-warning"
      @tt = "Thất bại!"
      @icon = "fa fa-exclamation-triangle"
      @text = ""
    end
  end

  def get_exam_lessons lesson, course_id
    course = Course.find_by id: course_id
    course_user_lessons = course.course_user_lessons.of_lesson lesson
    @exam_lessons = Array.new
    course_user_lessons.each do |x|
      next unless x.course_user.user.trainee?
      name = x.course_user.user.name
      length = x.exam_lessons.length
      best_exam = x.exam_lessons.score_desc.first
      max_score = best_exam.score if best_exam
      result = best_exam.result if best_exam
      @exam_lessons << [name,length,max_score||=0,result||="nil", x.id]
    end
  end
end
