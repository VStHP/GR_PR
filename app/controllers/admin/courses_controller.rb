class Admin::CoursesController < ApplicationController
  load_and_authorize_resource param_method: :params_course
  before_action :allow_admin, only: :index
  before_action :set_course, only: %i(change_status)
  after_action :add_course_user_task, only: :create
  after_action :modify_course_user_task, only: :update

  def new
    @trainers = User.filter_by "trainer"
    @trainees = User.trainees
    @subjects = Subject.all
  end

  def create
    if @course.save
      flash[:success] = "Tạo khóa học thành công!"
      redirect_to admin_course_path @course
    else
      flash[:danger] = "CẢNH BÁO! Thất bại, hãy thử lại."
      @trainers = User.filter_by "trainer"
      @trainees = User.trainees
      @subjects = Subject.all
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
    @trainees = User.filter_by "trainee"
    @subjects = Subject.all
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

  def show
    @course_subjects = @course.course_subjects
    @subjects = @course.subjects
    @trainers = @course.users.trainers
    @trainees = @course.users.trainees
  end

  private

  def set_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:errors] = "Không tìm thấy khóa học phù hợp"
    redirect_to root_path
  end

  def params_course
    pr = params[:course].permit :id, :name, :description, :user_id, :date_start,
      :language, :banner, :avatar, :program, links_attributes: [:id, :name, :link, :description,:course_id, :_destroy]
    pr.merge subject_ids: params[:course][:subject_ids], user_ids: params[:course][:user_ids]
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

  def add_course_user_task
    @course.course_users.each do |course_user|
      Task.in_subject_ids(params[:course][:subject_ids]).each do |task|
        course_user.course_user_tasks.create task_id: task.id
      end
    end
  end

  def modify_course_user_task
    @subject_ids_new = @course.subject_ids
    if @course.course_subjects.present?
      @subject_ids_old = @course.course_users.first.tasks.pluck(:subject_id)
    else
      @subject_ids_old = []
    end
    if (@subject_ids_new-@subject_ids_old).present?
      (@subject_ids_new-@subject_ids_old).each do |subject_id|
        Subject.find(subject_id).tasks.each do |task|
          @course.course_users.each do |cu|
            cu.course_user_tasks.create! task_id: task.id
          end
        end
      end
    end
    if (@subject_ids_old-@subject_ids_new).present?
      (@subject_ids_old-@subject_ids_new).each do |subject_id|
        Subject.find(subject_id).tasks.each do |task|
          task.course_user_tasks.delete_all
        end
      end
    end
    @course.course_users.each do |cu|
      if cu.id_previously_changed?
        if (@subject_ids_old&@subject_ids_new).present?
          (@subject_ids_old&@subject_ids_new).each do |subject_id|
            Subject.find(subject_id).tasks.each do |task|
              cu.course_user_tasks.create! task_id: task.id
            end
          end
        end
      end
    end
  end
end
