class ExamSubject < ApplicationRecord
  belongs_to :subject
  belongs_to :course_user
  has_many :list_question_answers, dependent: :destroy
  has_many :questions, through: :list_question_answers
end
