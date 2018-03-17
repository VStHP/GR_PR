class Admin::CoursesController < ApplicationController
  load_and_authorize_resource param_method: :params_course
  before_action :set_course, only: %i(change_status)

  def new
    @course = Course.new
    @trainers = User.filter_by "trainer"
  end

  def create
    @course = Course.new params_course
    if @course.save
      flash[:success] = "Tạo khóa học thành công! Bây giờ hãy thêm Môn học và tài khoản cho khóa học."
      redirect_to edit_admin_course_path @course.id
    else
      flash[:danger] = "CẢNH BÁO! Thất bại, hãy thử lại."
      @trainers = User.filter_by "trainer"
      render :new
    end
  end

  def change_status
    if @course.block?
      do_change_status @course, "in_progress"
    else
      do_change_status @course, "block"
    end
  end

  def index
    @courses = Course.filter_by params[:type]
  end

  def destroy
    if @course.init?
      if @course.destroy
        @mes_success = "Xóa khóa học thành công"
      else
        @mes_danger = "CẢNH BÁO! Xóa khóa học thất bại"
      end
    else
      @mes_danger = "CẢNH BÁO! Không thể xóa khóa học đã bắt đầu"
    end
  end

  def edit
    @trainers = User.filter_by "trainer"
  end

  def update
    if @course.update_attributes params_course
      flash[:success] = "Cập nhật khóa học thành công"
      redirect_to root_path
    else
      flash[:danger] = "CẢNH BÁO! Không thể cập nhật khóa học"
      @trainers = User.filter_by "trainer"
      render :edit
    end
  end

  private

  def set_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:errors] = "Không tìm thấy khóa học phù hợp"
    redirect_to root_path
  end

  def params_course
    params.require(:course).permit :id, :name, :description, :user_id, :date_start,
      :language, :banner, :avatar, :program
  end

  def do_change_status course, status
    if course.update_attribute :status, status
      if status == "block"
        @mes_success = "#{course.name} đã bị khóa"
      else
        @mes_success = "#{course.name} đã được mở khóa"
      end
    else
      @mes_danger = "CẢNH BÁO! Không thể thay đổi trạng thái khóa học"
    end
  end
end
