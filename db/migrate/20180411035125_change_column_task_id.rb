class ChangeColumnTaskId < ActiveRecord::Migration[5.1]
  def change
    rename_column :links, :task_id, :lesson_id
    rename_column :surveys, :task_id, :lesson_id
  end
end
