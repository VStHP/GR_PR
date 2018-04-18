class ExamLesson < ApplicationRecord
  belongs_to :course_user
  belongs_to :lesson
  has_many :list_question_answers, dependent: :destroy

  scope :of_lesson, ->(id){where lesson_id: id}

  accepts_nested_attributes_for :list_question_answers

  enum result: [:fail, :pass]
end
