class DeleteAndAddColumnIntoCourse < ActiveRecord::Migration[5.1]
  def change
    remove_column :courses, :standard
    add_column :courses, :language, :string
  end
end
