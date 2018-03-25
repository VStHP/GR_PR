class CourseUser < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :course_user_tasks, dependent: :destroy
  has_many :tasks, through: :course_user_tasks

  validates :course_id, uniqueness: { scope: :user_id }

  enum status: [:active, :block]

  def self.trainees
    joins(:user)
    .where("`users`.`id`=`course_users`.`user_id` and `permission`= 0 ")
  end
end
