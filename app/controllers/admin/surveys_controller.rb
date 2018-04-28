class Admin::SurveysController < ApplicationController
  load_and_authorize_resource param_method: :params_survey
  before_action :load_subject, only: :reload_lesson
  def index
    if params[:type] == "block"
      @surveys = Survey.filter_by_status "block"
    else
      @surveys = Survey.filter_by_status "ready"
    end
  end

  def new
    @subjects = Subject.all
    @lessons = @subjects.first.lessons
  end

  def create
    @survey.lesson_id = nil if @survey.subject_test?
    if @survey.save
      flash[:success] = "Tạo bài kiểm tra thành công"
      redirect_to admin_surveys_path
    else
      flash[:danger] = "Tạo bài kiểm tra thất bại"
      @subjects = Subject.all
      @lessons = @subjects.first.lessons
      render :new
    end
  end

  def edit
    @subjects = Subject.all
    @lessons = @survey.subject.lessons
  end

  def update
    if @survey.update_attributes params_survey
      flash[:success] = "Cập nhật bài kiểm tra thành công"
      redirect_to admin_surveys_path
    else
      flash[:danger] = "Cập nhật bài kiểm tra thất bại"
      render :edit
    end
  end

  def show
    @questions = @survey.questions
  end

  def reload_lesson
    return if @mes_error.present?
    @lessons = @subject.lessons
  end

  def destroy
    respond_to do |format|
      if @survey.destroy
        format.js{@mes_success = "Xóa bài kiểm tra thành công"}
      else
        format.js{@mes_danger = "Xóa bài kiểm tra thất bại"}
      end
    end
  end

  def change_status
    if @survey.block?
      do_change_status @survey, "ready"
    else
      do_change_status @survey, "block"
    end
  end

  private

  def params_survey
    params.require(:survey).permit( :name, :description, :time, :subject_id, :lesson_id, :type_test,
      questions_attributes: [:id, :text, :survey_id, :_destroy,
      answers_attributes: [:id, :text, :correct, :question_id, :_destroy]])
  end

  def load_subject
    @subject = Subject.find_by name: params[:name]
    return if @subject
    @mes_error =  "Đã có lỗi xảy ra!"
  end

  def do_change_status survey, status
    respond_to do |format|
      if survey.update_attribute :status, status
        if status == "block"
          format.js{@mes_success = "#{survey.name} đã bị khóa"}
        else
          format.js{@mes_success = "#{survey.name} đã được mở khóa"}
        end
      else
        format.js{@mes_danger = "CẢNH BÁO! Không thể thay đổi trạng thái bài kiểm tra"}
      end
    end
  end
end
