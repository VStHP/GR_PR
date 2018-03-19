class Admin::CourseSubjectsController < ApplicationController
  load_and_authorize_resource except: :create
  before_action :load_course, only: %i(create update)
  before_action :load_course_subject, only: :update
  before_action :check_allow_update_status, only: :update

  def create
    binding.pry
    flash[:success] = "Thêm môn học vào khóa học thành công"
    params[:subjects].each do |id|
      next if @course.course_subjects.create subject_id: id
      flash[:warning] = "Đã có lỗi khi thêm 1 số môn học"
    end
    redirect_to edit_admin_course_path @course
  end

  def show
    @subject = Subject.find_by id: params[:subject_id]
    @course_subject = @subject.course_subjects.find_by course_id: params[:course_id]
    @course = Course.find_by id: params[:course_id]
  end

  def update
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
    redirect_to admin_courses_path
  end

  def load_course_subject
    @course_subject = @course.course_subjects.find_by subject_id: params[:subject_id]
  end

  def check_allow_update_status
    return if @course.in_progress? && @course.course_subjects.in_progress.blank?
    return if @course.in_progress? && @course_subject.in_progress?
    @mes_error = "Không thể thay đổi trạng thái môn học này khi chưa hoàn thành môn học kia."
  end
end
