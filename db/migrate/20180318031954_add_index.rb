class AddIndex < ActiveRecord::Migration[5.1]
  def change
    add_index :course_subjects, [:course_id, :subject_id], unique: true
    add_index :course_users, [:course_id, :user_id], unique: true
  end
end
