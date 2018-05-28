class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.string :youtube_url
      t.references :subject

      t.timestamps
    end
  end
end
