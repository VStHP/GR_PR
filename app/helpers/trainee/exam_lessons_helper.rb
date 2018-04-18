module Trainee::ExamLessonsHelper
  def define_object_show_exam_lesson lqa
    @question = Question.find_by id: lqa.question_id
    @answers = Answer.find lqa.answer_ids
  end

  def define_class exam_lesson
    case exam_lesson.result
    when "pass"
      "bg-success"
    else
      "bg-failed"
    end
  end
end
