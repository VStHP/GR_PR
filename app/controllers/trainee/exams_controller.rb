class Trainee::ExamsController < ApplicationController
  def index
    @exam_lessons = current_user.exam_lessons
  end
end
