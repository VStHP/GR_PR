class CourseUserTask < ApplicationRecord
  belongs_to :course_user
  belongs_to :task

  scope :of_task, ->(task){where task_id: task.id}
  scope :of_task_ids, ->(ids){where("task_id in (?)", ids)}
  scope :of_course_user, ->(id){where course_user_id: id}
  scope :in_progress, ->{where status: "in_progress"}
  scope :finish, ->{where status: "finish"}

  enum status: [:init, :in_progress, :finish]

  def self.chart_data
    group("`course_user_id`")
    .pluck("`course_user_id`, count(`course_users`.`id`) as num_task")
  end
end
