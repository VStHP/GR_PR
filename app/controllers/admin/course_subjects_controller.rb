class Admin::CourseSubjectsController < ApplicationController
  before_action :load_course
  before_action :load_course_subject
  before_action :check_allow_update_status, only: :update

  def show
    authorize! :show, @course_subject
    @subject = @course_subject.subject
    @tasks = @subject.tasks
  end

  def update
    authorize! :update, @course_subject
    return if @mes_error.present?
    @subject = @course_subject.subject
    if @course_subject.update_attributes status: params[:status]
      if params[:status] == "in_progress"
        @course_subject.update_attributes date_start: Time.zone.now
      else
        @course_subject.update_attributes date_end: Time.zone.now
      end
      @mes_success = "Thay đổi trạng thái môn học thành công"
    else
      @mes_error = "Thay đổi trạng thái môn học thất bại"
    end
  end

  private

  def load_course
    @course = Course.find_by id: params[:course_id]
    return if @course
    flash[:danger] = "Đã có lỗi xảy ra với khóa học, hãy thử lại."
    redirect_to root_path
  end

  def load_course_subject
    @course_subject = @course.course_subjects.find_by subject_id: params[:subject_id]
    return if @course_subject
    flash[:danger] = "Đã có lỗi xảy ra với khóa học, hãy thử lại."
    redirect_to root_path
  end

  def check_allow_update_status
    return if @course.in_progress? && @course.course_subjects.in_progress.blank?
    return if @course.in_progress? && @course_subject.in_progress?
    @mes_error = "Chỉ áp dụng khi khóa học đang bắt đầu và không có môn học nào đang tiến hành."
  end
end
