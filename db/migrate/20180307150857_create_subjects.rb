class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :name, null: false
      t.text :description
      t.integer :day_on_learn
      t.timestamps
    end
  end
end
