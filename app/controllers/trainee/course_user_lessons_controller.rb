class Trainee::CourseUserLessonsController < ApplicationController
  load_and_authorize_resource
  before_action :load_course
  before_action :load_subject
  before_action :load_course_subject
  before_action :check_allow_update_status
  before_action :redirect_to_test_page

  def update
    return if @redirect || @mes_error
    respond_to do |format|
      if params[:status] == "in_progress"
        if @course_user_lesson.update_attributes status: params[:status]
          @course_user_lesson.update_attributes date_start: Time.zone.now
          format.js{@mes_success = "Kích hoạt bài học thành công! Bắt đầu học thôi nào"}
        else
          format.js{@mes_error = "Thay đổi trạng thái bài học thất bại"}
        end
      elsif params[:status] == "finish"
        if @course_user_lesson.update_attributes status: params[:status]
          @course_user_lesson.update_attributes date_end: Time.zone.now
          format.js{@mes_success = "Chúc mừng bạn đã hoàn thành bài học! Bài học này không có kiểm tra"}
        else
          format.js{@mes_error = "Thay đổi trạng thái bài học thất bại"}
        end
      end
    end
  end

  private

  def redirect_to_test_page
    @redirect = :true if params[:status] == "finish" && @course_user_lesson.lesson.questions.present?
  end

  def check_allow_update_status
    @list = @subject.course_user_lessons.of_course_user(@course_user_lesson.course_user_id).in_progress
    return if @course.in_progress? && @course_subject.in_progress? && @list.blank?
    return if @course.in_progress? && @course_subject.in_progress? && @list.include?(@course_user_lesson)
    @mes_error = "Khóa thực tập và môn học phải đang triển khai và phải hoàn thành các bài học đang thực hiện"
  end

  def load_course
    @course = @course_user_lesson.course_user.course
    return if @course.present?
    @mes_error = "Không tìm thấy khóa thực tập phù hợp!"
  end

  def load_subject
    @subject = @course_user_lesson.lesson.subject
    return if @subject.present?
    @mes_error = "Không tìm thấy môn học phù hợp!"
    redirect_back fallback_location: root_path
  end

  def load_course_subject
    @course_subject = CourseSubject.find_by course_id: @course.id, subject_id: @subject.id
    return if @course_subject.present?
    @mes_error = "Không tìm thấy môn học phù hợp!"
  end
end
