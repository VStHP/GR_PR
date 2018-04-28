class FixListQuestionAnswerColumn < ActiveRecord::Migration[5.1]
  def change
    remove_reference :list_question_answers, :course_users, index: true, foreign_key: true
    add_reference :list_question_answers, :exam_subject, index: true, foreign_key: true
  end
end
