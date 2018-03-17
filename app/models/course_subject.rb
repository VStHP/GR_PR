class CourseSubject < ApplicationRecord
  belongs_to :course
  belongs_to :subject

  enum status: [:init, :in_progress, :finish, :block]
end
