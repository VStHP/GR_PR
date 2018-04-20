class ExamLesson < ApplicationRecord
  belongs_to :course_user_lesson
  has_many :list_question_answers, dependent: :destroy

  scope :score_desc, ->{order(score: :desc)}
  accepts_nested_attributes_for :list_question_answers

  enum result: [:fail, :pass]
end
