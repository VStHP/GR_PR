class CourseUserLesson < ApplicationRecord
  belongs_to :course_user
  belongs_to :lesson
  has_many :exam_lessons, dependent: :destroy

  validates :course_user_id, uniqueness: { scope: :lesson_id }

  scope :of_lesson, ->(lesson){where lesson_id: lesson.id}
  scope :of_lesson_ids, ->(ids){where("lesson_id in (?)", ids)}
  scope :of_course_user, ->(id){where course_user_id: id}
  scope :in_progress, ->{where status: "in_progress"}
  scope :finish, ->{where status: "finish"}

  enum status: [:init, :in_progress, :finish, :finish_fail]

  def self.chart_data
    group("`course_user_id`")
    .pluck("`course_user_id`, count(`course_users`.`id`) as num_lesson")
  end
end
