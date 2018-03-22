class Subject < ApplicationRecord
  has_many :tasks
  has_many :links
  has_many :course_subjects
  has_many :courses, through: :course_subjects
  has_many :course_users, through: :courses

  validates :id, length: {minimum: 4, maximum: 10}, presence: true, uniqueness: {case_sensitive: false}
  validates :name, length: {maximum: 250}, presence: true, uniqueness: {case_sensitive: false}
  validates :description, length: {maximum: 5000}
  validates :day_on_learn, numericality: { other_than: 0 }, presence: true

  scope :filter_block, ->{where status: "block"}
  scope :filter_active, ->{where status: "active"}

  accepts_nested_attributes_for :tasks, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  mount_uploader :avatar, AvatarSubjectUploader
  enum status: [:active, :block]

end
