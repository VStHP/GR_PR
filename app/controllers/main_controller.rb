class MainController < ApplicationController
  def index
    if current_user.admin?
      redirect_to admin_courses_path
    elsif current_user.trainer?
      redirect_to trainer_courses_path
    else current_user.trainee?
      redirect_to mycourses_path
    end
  end
end
