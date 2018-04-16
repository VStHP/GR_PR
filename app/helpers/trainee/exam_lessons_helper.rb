module Trainee::ExamLessonsHelper
  def define_object_show_exam_lesson lqa
    @question = Question.find_by id: lqa.question_id
    @answers = Answer.find lqa.answer_ids
  end
end
