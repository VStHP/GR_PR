class CreateCourseUserSurveys < ActiveRecord::Migration[5.1]
  def change
    create_table :course_user_surveys do |t|
      t.references :course_user, foreign_key: true
      t.references :survey, foreign_key: true
      t.float :score
      t.integer :result
      t.float :time

      t.timestamps
    end
  end
end
