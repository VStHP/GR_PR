class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.string :name
      t.string :link
      t.text :description
      t.references :task, foreign_key: true
      t.string :subject_id
      t.string :course_id

      t.timestamps
    end
    add_index :links, :subject_id
    add_index :links, :course_id
    add_foreign_key :links, :subjects, column: :subject_id, primary_key: "id"
    add_foreign_key :links, :courses, column: :course_id, primary_key: "id"
  end
end
