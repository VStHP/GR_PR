class ChangeNameColumnTaskIdAndRenameTableCourseUserTask < ActiveRecord::Migration[5.1]
  def change
    rename_column :course_user_tasks, :task_id, :lesson_id
    rename_table :course_user_tasks, :course_user_lessons
  end
end
