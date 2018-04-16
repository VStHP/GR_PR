class ListQuestionAnswer < ApplicationRecord
  belongs_to :question
  belongs_to :exam_subject, optional: true
  belongs_to :exam_lesson, optional: true

  serialize :answer_ids
end
