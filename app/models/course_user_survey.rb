class CourseUserSurvey < ApplicationRecord
  belongs_to :courseusers
  belongs_to :surveys
end
