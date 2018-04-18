class CourseUser < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :course_user_lessons, dependent: :destroy
  has_many :lessons, through: :course_user_lessons
  has_many :exam_lessons

  validates :course_id, uniqueness: { scope: :user_id }

  enum status: [:active, :block]

  def self.trainees
    joins(:user)
    .where("`users`.`id`=`course_users`.`user_id` and `permission`= 0 ")
  end
end
