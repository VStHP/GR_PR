class ChangeRefereceExamLesson < ActiveRecord::Migration[5.1]
  def change
    remove_reference :exam_lessons, :course_user, index: true, foreign_key: true
    remove_reference :exam_lessons, :lesson, index: true, foreign_key: true
    add_reference :exam_lessons, :course_user_lesson, index: true, foreign_key: true
  end
end
