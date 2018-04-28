class AddColumnNumQuestionInTest < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :num_question_test, :integer, default: 20
  end
end
