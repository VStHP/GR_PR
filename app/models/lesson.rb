class Lesson < ApplicationRecord
  belongs_to :subject
  has_many :links, dependent: :destroy
  has_many :course_user_lessons, dependent: :destroy
  has_many :course_users, through: :course_user_lessons
  has_many :exam_lesson, through: :course_user_lessons
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions

  validates :name, length: {maximum: 250}, presence: true
  validates :description, length: {maximum: 5000}
  validates :youtube_url, length: {maximum: 250}
  validates :num_question_test, numericality: { greater_than: 0  }, if: :num_question_test?
  validate :test_time_presence
  validate :num_question_test_presence

  scope :in_subject_ids, ->(ids){where("subject_id in (?)", ids)}

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  def test_time_presence
    return if self.questions.blank?
    errors.add :test_time, "Thời gian làm bài không thể để trống" unless test_time?
  end

  def num_question_test_presence
    return if self.questions.blank?
    errors.add :num_question_test, "Số câu trong 1 bài kiểm tra không thể để trống" unless num_question_test?
  end
end
