class ChangeTypeAnswerIds < ActiveRecord::Migration[5.1]
  def change
    change_column :list_question_answers, :answer_ids, :string
  end
end
