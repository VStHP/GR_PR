class AddColumnTypetestToSurveys < ActiveRecord::Migration[5.1]
  def change
    add_column :surveys, :type, :integer, default: 0
  end
end
