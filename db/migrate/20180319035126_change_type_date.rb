class ChangeTypeDate < ActiveRecord::Migration[5.1]
  def change
    change_column :courses, :date_start, :datetime
    change_column :courses, :date_end, :datetime
    change_column :course_subjects, :date_start, :datetime
    change_column :course_subjects, :date_end, :datetime
  end
end
