class Admin::SubjectsController < ApplicationController
  load_and_authorize_resource param_method: :params_subject
  after_action :add_course_user_task, only: :update
  def index
    if params[:type]
      @subjects = Subject.filter_block
    else
      @subjects = Subject.filter_active
    end
  end

  def new
    @subject = Subject.new
    1.times { @subject.tasks.build}
    1.times { @subject.links.build}
  end

  def create
    if @subject.save
      flash[:success] = "Tạo môn học thành công"
      redirect_to root_path
    else
      flash[:danger] = "CẢNH BÁO! Tạo môn học thất bại"
      render :new
    end
  end

  def edit; end

  def show
    @courses = @subject.courses
    @tasks = @subject.tasks
  end

  def update
    if @subject.update_attributes params_subject
      flash[:success] = "Cập nhật môn học thành công"
      redirect_to admin_subjects_path
    else
      flash[:danger] = "CẢNH BÁO! Cập nhật môn học thất bại"
      render :edit
    end
  end

  def change_status
    if @subject.block?
      do_change_status @subject, "active"
    else
      do_change_status @subject, "block"
    end
  end

  private

  def set_subject
    @subject = Subject.find_by id: params[:id]
    return if @subject
    flash[:danger] = "Không tìm thấy môn học phù hợp"
    redirect_to root_path
  end

  def params_subject
    params.require(:subject).permit( :id, :name, :description, :day_on_learn, :avatar,
      links_attributes: [:id, :name, :link, :description,:subject_id, :_destroy],
      tasks_attributes: [:id, :name, :description, :subject_id, :_destroy, :youtube_url])
  end

  def do_change_status subject, status
    if subject.update_attribute :status, status
      if status == "block"
        @mes_success = "#{subject.name} đã bị khóa"
      else
        @mes_success = "#{subject.name} đã được mở khóa"
      end
    else
      @mes_danger = "CẢNH BÁO! Không thể thay đổi trạng thái khóa học"
    end
  end

  def add_course_user_task
    @subject.tasks.each do |task|
      if task.id_previously_changed?
        @subject.course_users.each do |cu|
          cu.course_user_tasks.create! task_id: task.id
        end
      end
    end
  end
end
