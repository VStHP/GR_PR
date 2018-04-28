class Admin::LessonsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
    @questions = @lesson.questions
  end

  def edit
  end

  def update
    if @lesson.update_attributes params_lesson
      flash[:success] = "Thao tác câu hỏi trên bài học thành công"
      redirect_to admin_lesson_path(@lesson)
    else
      flash[:danger] = "Thao tác câu hỏi trên bài học thất bại"
      render :edit
    end
  end

  def export_lesson_exam
    @questions = @lesson.questions
    respond_to do |format|
      format.xls
    end
  end
  private

  def params_lesson
    params.require(:lesson).permit :id, :test_time, :num_question_test,
      questions_attributes: [:id, :text, :lesson_id, :_destroy,
      answers_attributes: [:id, :text, :correct, :question_id, :_destroy]]
  end
end
