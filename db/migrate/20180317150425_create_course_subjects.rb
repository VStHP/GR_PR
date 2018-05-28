class CreateCourseSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :course_subjects do |t|
      t.string :course_id
      t.string :subject_id
      t.integer :status, default: 0
      t.date :date_start
      t.date :date_end

      t.timestamps
    end
    add_index :course_subjects, :subject_id
    add_index :course_subjects, :course_id
    add_foreign_key :course_subjects, :subjects, column: :subject_id, primary_key: "id"
    add_foreign_key :course_subjects, :courses, column: :course_id, primary_key: "id"
  end
end
