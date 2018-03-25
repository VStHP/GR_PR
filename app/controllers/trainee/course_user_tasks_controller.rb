class Trainee::CourseUserTasksController < ApplicationController
  load_and_authorize_resource
  before_action :load_course
  before_action :load_subject
  before_action :load_course_subject
  before_action :check_allow_update_status

  def update
    #replace @mes_danger => flash[:danger], @mes_success => flash[:success] in stead ajax
    # return if flash[:danger].present?
    if @course_user_task.update_attributes status: params[:status]
      case params[:status]
      when "in_progress"
        flash[:success] = "Kích hoạt chương thành công! Bắt đầu học thôi nào"
        @course_user_task.update_attributes date_start: Time.zone.now
      when "finish"
        flash[:success] = "Chúc mừng! Bạn đã hoàn thành chương!"
        @course_user_task.update_attributes date_end: Time.zone.now
      end
    else
      flash[:danger] = "Thay đổi trạng thái chương thất bại"
    end
    redirect_back fallback_location: root_path
  end

  private

  def check_allow_update_status
    @list = @subject.course_user_tasks.of_course_user(@course_user_task.course_user_id).in_progress
    return if @course.in_progress? && @course_subject.in_progress? && @list.blank?
    return if @course.in_progress? && @course_subject.in_progress? && @list.include?(@course_user_task)
    flash[:danger] = "CẢNH BÁO! Khóa học và môn học phải đang triển khai và phải hoàn thành các chương đang thực hiện"
    redirect_back fallback_location: root_path
  end

  def load_course
    @course = @course_user_task.course_user.course
    return if @course.present?
    flash[:danger] = "Không tìm thấy khóa học phù hợp!"
    redirect_back fallback_location: root_path
  end

  def load_subject
    @subject = @course_user_task.task.subject
    return if @subject.present?
    flash[:danger] = "Không tìm thấy môn học phù hợp!"
    redirect_back fallback_location: root_path
  end

  def load_course_subject
    @course_subject = CourseSubject.find_by course_id: @course.id, subject_id: @subject.id
    return if @course_subject.present?
    flash[:danger] = "Không tìm thấy môn học phù hợp!"
    redirect_back fallback_location: root_path
  end
end
