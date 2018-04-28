class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :name, null: false
      t.references :user, foreign_key: true
      t.string :program
      t.string :standard
      t.string :banner
      t.string :avatar
      t.date :date_start
      t.date :date_end
      t.integer :status, default: 0
      t.text :description

      t.timestamps
    end
  end
end
