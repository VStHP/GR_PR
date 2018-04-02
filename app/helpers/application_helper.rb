module ApplicationHelper
  def full_title page_title = ""
    base_title = "Hệ thống quản lý khóa học trực tuyến"
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

  def define_course_user_task task, course_id
    @course_user_task = current_user.course_users.find_by(course_id: course_id).course_user_tasks.of_task(task)[0]
    case @course_user_task.status
    when "init"
      @cll = ""
      @url = report_progress_path(id: @course_user_task.id, status: "in_progress")
      @class = "btn btn-xs btn-info"
      @tt = "Nhấn để nhận chương"
      @icon = "fa fa-play"
      @text = " Bắt đầu"
    when "in_progress"
      @cll = "task-active"
      @url = report_progress_path(id: @course_user_task.id, status: "finish")
      @class = "btn btn-xs btn-danger"
      @tt = "Nhấn để kết thúc chương"
      @icon = "fa fa-flag"
      @text = " Kết thúc"
    else
      @cll = "task-finish"
      @url = "#"
      @class = "btn btn-xs btn-success"
      @tt = "Hoàn thành!"
      @icon = "fa fa-check"
      @text = ""
    end
  end
end
