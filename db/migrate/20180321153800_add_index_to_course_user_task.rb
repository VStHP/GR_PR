class AddIndexToCourseUserTask < ActiveRecord::Migration[5.1]
  def change
    add_index :course_user_tasks, [:course_user_id, :task_id], unique: true
  end
end
