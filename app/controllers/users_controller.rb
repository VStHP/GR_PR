class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: :change_avatar

  def show; end

  def change_avatar
    if @user.update_attributes avatar_params
      @mes_success = "Update avatar successfully!"
    else
      @mes_danger = "Update avatar failed!"
    end
  end

  private

  def set_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:errors] = "Không tìm thấy tài khoản phù hợp"
    redirect_to root_path
  end

  def avatar_params
    params.require(:user).permit :avatar
  end
end
