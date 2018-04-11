class CreateSurveys < ActiveRecord::Migration[5.1]
  def change
    create_table :surveys do |t|
      t.string :name
      t.text :description
      t.string :subject_id
      t.references :task, foreign_key: true
      t.integer :time

      t.timestamps
    end
    add_index :surveys, :subject_id
    add_foreign_key :surveys, :subjects, column: :subject_id, primary_key: "id"
  end
end
