class ChangeNameTableTaskToLesson < ActiveRecord::Migration[5.1]
  def change
    rename_table :tasks, :lessons
  end
end
