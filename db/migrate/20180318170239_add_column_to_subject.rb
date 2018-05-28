class AddColumnToSubject < ActiveRecord::Migration[5.1]
  def change
    add_column :subjects, :avatar, :string
  end
end
