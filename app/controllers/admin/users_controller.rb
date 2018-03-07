class Admin::UsersController < ApplicationController
  before_action :set_user, except: [:index, :new, :export, :import]

  def index
    if params[:type] == "block"
      @users = User.filter_by_block
    else
      @users = User.filter_by_active.filter_by params[:type]
    end
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    set_password_default
    @user = User.new user_params
    if @user.save
      flash[:success] = "Tạo thành công tài khoản #{@user.permission}:#{@user.name}"
      redirect_to root_path
    else
      flash[:danger] = "Tạo thất bại tài khoản #{@user.permission}:#{@user.name}"
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      @mes_success = "Cập nhật hồ sơ thành công"
    else
      @mes_danger = "CẢNH BÁO! Cập nhật hồ sơ thất bại"
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_status_user
    if @user.active?
      do_change_status @user, "block"
    else
      do_change_status @user, "active"
    end
  end

  def change_avatar
    if @user.update_attributes avatar_params
      @mes_success = "Update avatar successfully!"
    else
      @mes_danger = "Update avatar failed!"
    end
  end

  def export
    if params[:type] == "all"
      @users = User.all
    else
      @users = User.filter_by params[:type]
    end
    respond_to do |format|
      format.csv { send_data @users.to_csv }
      format.xls
    end
  end

  def import
    User.import params[:file]
    flash[:success] = "Nhập người dùng từ file thành công"
    redirect_back fallback_location: root_path
  end

  private

  def set_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:errors] = "Không tìm thấy tài khoản phù hợp"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :permission,
      :gender, :birthday, :phone, :university, :program
  end

  def avatar_params
    params.require(:user).permit :avatar
  end

  def set_password_default
    params[:user][:password] = "123123"
    params[:user][:password_confirmation] = "123123"
  end

  def do_change_status user, status
    if user.update_attributes status: status
      if status == "block"
        @mes_success = "#{user.name} đã bị khóa"
      else
        @mes_success = "#{user.name} đã được mở khóa"
      end
    else
      @mes_danger = "CẢNH BÁO! Không thể thay đổi trạng thái tài khoản"
    end
  end

end
