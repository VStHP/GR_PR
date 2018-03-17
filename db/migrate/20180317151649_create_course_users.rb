class CreateCourseUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :course_users do |t|
      t.string :course_id
      t.references :user, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
    add_index :course_users, :course_id
    add_foreign_key :course_users, :courses, column: :course_id, primary_key: "id"
  end
end
