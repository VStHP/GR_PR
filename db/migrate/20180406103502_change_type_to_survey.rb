class ChangeTypeToSurvey < ActiveRecord::Migration[5.1]
  def change
    change_column :surveys, :type_test, :boolean
  end
end
