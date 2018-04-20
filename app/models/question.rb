class Question < ApplicationRecord
  belongs_to :lesson
  has_many :answers, dependent: :destroy
  has_many :list_question_answers, dependent: :destroy

  validates :text, presence: true, length: {maximum: 4, minimum: 250}

  scope :get_random, ->{order "rand()"}

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
end
