class AddReferencesToTask < ActiveRecord::Migration[5.1]
  def change
    remove_column :tasks, :subject_id
    add_column :tasks, :subject_id, :string
    add_index :tasks, :subject_id
    add_foreign_key :tasks, :subjects, column: :subject_id, primary_key: "id"
  end
end
