class Lesson < ApplicationRecord
  belongs_to :subject
  has_many :links, dependent: :destroy
  has_many :course_user_lessons, dependent: :destroy
  has_many :course_users, through: :course_user_lessons
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions

  validates :name, length: {maximum: 250}, presence: true
  validates :description, length: {maximum: 5000}
  validates :youtube_url, length: {maximum: 250}

  scope :in_subject_ids, ->(ids){where("subject_id in (?)", ids)}

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

end
