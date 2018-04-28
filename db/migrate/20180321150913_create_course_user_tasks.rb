class CreateCourseUserTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :course_user_tasks do |t|
      t.references :course_user, foreign_key: {on_delete: :cascade}
      t.references :task, foreign_key: {on_delete: :cascade}
      t.integer :status, default: 0
      t.datetime :date_start
      t.datetime :date_end
      t.timestamps
    end
  end
end
