class EditNameColumnReferenceToExam < ActiveRecord::Migration[5.1]
  def change
    remove_reference :exam_lessons, :course_users, index: true, foreign_key: true
    add_reference :exam_lessons, :course_user, index: true, foreign_key: true
    remove_reference :exam_lessons, :lessons, index: true, foreign_key: true
    add_reference :exam_lessons, :lesson, index: true, foreign_key: true
    remove_reference :exam_subjects, :course_users, index: true, foreign_key: true
    add_reference :exam_subjects, :course_user, index: true, foreign_key: true
    remove_reference :list_question_answers, :exam_lessons, index: true, foreign_key: true
    add_reference :list_question_answers, :exam_lesson, index: true, foreign_key: true
    remove_reference :list_question_answers, :questions, index: true, foreign_key: true
    add_reference :list_question_answers, :question, index: true, foreign_key: true
  end
end
