class UsersController < ApplicationController
  load_and_authorize_resource

  def show; end

  def change_avatar
    respond_to do |format|
      if @user.update_attributes avatar_params
        format.js{@mes_success = "Thay đổi ảnh đại diện thành công"}
      else
        format.js{@mes_danger = "Thay đổi ảnh đại diện thất bại"}
      end
    end
  end

  private

  def avatar_params
    params.require(:user).permit :avatar
  end
end
