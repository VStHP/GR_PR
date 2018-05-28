class ChangeDataTypeOfTypeTestToSurveys < ActiveRecord::Migration[5.1]
  def change
    change_column :surveys, :type_test, :integer
  end
end
