class CourseUserTask < ApplicationRecord
  belongs_to :course_user
  belongs_to :task
end
