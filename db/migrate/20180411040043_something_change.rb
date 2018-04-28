class SomethingChange < ActiveRecord::Migration[5.1]
  def change
    remove_reference :questions, :survey, index: true, foreign_key: true
    add_reference :questions, :lesson, index: true, foreign_key: true
    drop_table :course_user_surveys
    drop_table :surveys
    create_table :exam_subjects do |t|
      t.string :subject_id
      t.references :course_users, foreign_key: true
      t.float :score
      t.integer :result

      t.timestamps
    end
    add_index :exam_subjects, :subject_id
    add_foreign_key :exam_subjects, :subjects, column: :subject_id, primary_key: "id"
    create_table :exam_lessons do |t|
      t.references :course_users, foreign_key: true
      t.references :lessons, foreign_key: true
      t.float :score
      t.integer :result

      t.timestamps
    end
    create_table :list_question_answers do |t|
      t.references :exam_lessons, foreign_key: true
      t.references :course_users, foreign_key: true
      t.references :questions, foreign_key: true
      t.integer :answer_ids, array: true, default: []
      t.integer :chosen_id

      t.timestamps
    end
    add_column :subjects, :test_time, :integer
    add_column :lessons, :test_time, :integer
  end
end
