class RenameColumnTypeToSurvey < ActiveRecord::Migration[5.1]
  def change
    rename_column :surveys, :type, :type_test
  end
end
