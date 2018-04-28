class Trainer::CoursesController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:type] == "join"
      @courses = current_user.courses_join
    else
      @courses = current_user.courses
    end
  end
end
