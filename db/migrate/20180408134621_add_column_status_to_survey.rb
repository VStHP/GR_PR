class AddColumnStatusToSurvey < ActiveRecord::Migration[5.1]
  def change
    add_column :surveys, :status, :int, default: 0
  end
end
