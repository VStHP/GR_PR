class Trainer::UsersController < ApplicationController
  load_and_authorize_resource
  def index
    case params[:type]
    when "block"
      @users = User.trainees.filter_by_block
    when "trainee"
      @users = User.filter_by_active.trainees
    else
      @users = User.filter_by_active.trainers
    end
  end
end
