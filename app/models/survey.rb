class Survey < ApplicationRecord
  belongs_to :subject, optional: true
  belongs_to :lesson, optional: true
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions
  has_many :course_user_surveys

  validates :name, presence: true, length: {minimum: 4, maximum: 250}, uniqueness: {case_sensitive: false}
  validates :time, presence: true, numericality: { other_than: 0 }
  validates :subject_id, presence: true
  validates :lesson_id, presence: true, unless: :type_test?
  validates :description, length: {maximum: 5000}

  scope :filter_by_status, ->(status){where status: status}


  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  enum type_test: [:lesson_test, :subject_test]
  enum status: [:ready, :block]
end
