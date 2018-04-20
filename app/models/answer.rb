class Answer < ApplicationRecord
  belongs_to :question

  validates :text, presence: true, length: {maximum: 250}

  scope :get_random, ->{order "rand()"}
  scope :right, ->{where correct: "true"}
  scope :wrong, ->{where correct: "false"}

  enum correct: [:false, :true]
end
