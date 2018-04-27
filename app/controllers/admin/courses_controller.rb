class Admin::CoursesController < ApplicationController
  load_and_authorize_resource param_method: :params_course
  before_action :allow_admin, only: :index
  after_action :modify_course_user_lesson, only: :update
  after_action :check_and_active_course, only: %i(create update)

  def new
    @trainers = User.trainer
    trainees = Array.new
    Course.in_progress.each { |x| trainees+= x.users.trainees }
    Course.init.each { |x| trainees+= x.users.trainees }
    @trainees = User.trainees - trainees
    @subjects = Subject.all
  end

  def create
    if @course.save
      flash[:success] = "Tạo khóa thực tập thành công"
      add_course_user_lesson
      redirect_to admin_course_path @course
    else
      flash[:danger] = "Tạo khóa thực tập thất bại"
      @trainers = User.trainer
      trainees = Array.new
      Course.in_progress.each { |x| trainees+= x.users.trainees }
      Course.init.each { |x| trainees+= x.users.trainees }
      @trainees = User.trainees - trainees
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
    if params[:type].present?
      @courses = Course.filter_by params[:type]
    else
      @courses = Course.filter_by "init"
    end
  end

  def destroy
    respond_to do |format|
      if @course.init?
        if @course.destroy
          format.js{@mes_success = "Xóa khóa thực tập thành công"}
        else
          format.js{@mes_danger = "Xóa khóa thực tập thất bại"}
        end
      else
        format.js{@mes_danger = "Không thể xóa khóa thực tập đã bắt đầu"}
      end
    end
  end

  def edit
    @trainers = User.trainer
    trainees = Array.new
    Course.in_progress.each { |x| trainees+= x.users.trainee }
    Course.init.each { |x| trainees+= x.users.trainee }
    @trainees = User.trainee - trainees + @course.users.trainee
    @subjects = Subject.all
  end

  def update
    @course.update_attributes params_course
    if @course.save
      flash[:success] = "Cập nhật khóa thực tập thành công"
      if current_user.admin?
        redirect_to admin_course_path @course
      else
        redirect_to course_path @course
      end
    else
      flash[:danger] = "Không thể cập nhật khóa thực tập"
      @trainers = User.filter_by "trainer"
      trainees = Array.new
      Course.in_progress.each { |x| trainees+= x.users.trainees }
      Course.init.each { |x| trainees+= x.users.trainees }
      @trainees = User.trainees - trainees + @course.users.trainees
      @subjects = Subject.all
      render :edit
    end
  end

  def show
    @course_subjects = @course.course_subjects
    @subjects = @course.subjects
    @trainers = @course.users.trainers
    @trainees = @course.users.trainees
  end

  def export
    if params[:type] == "all"
      @courses = Course.all
    else
      @courses = Course.filter_by params[:type]
    end
    respond_to do |format|
      format.csv { send_data @courses.to_csv }
      format.xls
    end
  end

  def export_course
    @course_subjects = @course.course_subjects
    @subjects = @course.subjects
    @trainers = @course.users.trainers
    @trainees = @course.users.trainees
    respond_to do |format|
      format.xls
    end
  end

  def import
    Course.import params[:file]
    flash[:success] = "Nhập khóa thực tập từ file thành công"
    redirect_back fallback_location: root_path
  end

  private

  def set_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:danger] = "Không tìm thấy khóa thực tập phù hợp"
    redirect_to root_path
  end

  def params_course
    pr = params[:course].permit :id, :name, :description, :user_id, :date_start,
      :language, :banner, :avatar, :program, links_attributes: [:id, :name, :link, :description,:course_id, :_destroy]
    pr.merge subject_ids: params[:course][:subject_ids], user_ids: params[:course][:user_ids]
  end

  def do_change_status course, status
    respond_to do |format|
      if course.update_attribute :status, status
        if status == "block"
          format.js{@mes_success = "#{course.name} đã bị khóa"}
        else
          format.js{@mes_success = "#{course.name} đã được mở khóa"}
        end
      else
        format.js{@mes_danger = "Không thể thay đổi trạng thái khóa thực tập"}
      end
    end
  end

  def add_course_user_lesson
    @course.course_users.each do |course_user|
      Lesson.in_subject_ids(params[:course][:subject_ids]).each do |lesson|
        course_user.course_user_lessons.create lesson_id: lesson.id
      end
    end
  end

  def modify_course_user_lesson
    #danh sach id subject hien tai cua course
    @subject_ids_new = @course.subject_ids
    if @course.course_subjects.present?
      #danh sach id subject truoc do cua course
      @subject_ids_old = @course.course_users.first.lessons.pluck(:subject_id)
    else
      @subject_ids_old = []
    end
    #neu co mon hoc moi duoc them => course_user_lesson add
    if (@subject_ids_new-@subject_ids_old).present?
      (@subject_ids_new-@subject_ids_old).each do |subject_id|
        Subject.find(subject_id).lessons.each do |lesson|
          @course.course_users.each do |cu|
            cu.course_user_lessons.create! lesson_id: lesson.id
          end
        end
      end
    end
    #Neu co mon hoc cu bi xoa => course_user_lesson destroy
    if (@subject_ids_old-@subject_ids_new).present?
      (@subject_ids_old-@subject_ids_new).each do |subject_id|
        Subject.find(subject_id).lessons.each do |lesson|
          lesson.course_user_lessons.delete_all
        end
      end
    end
    #kiem tra cac thuc tap sinh moi them vao => course_user_lesson add
    @course.course_users.each do |cu|
      if cu.id_previously_changed?
        if (@subject_ids_old&@subject_ids_new).present?
          (@subject_ids_old&@subject_ids_new).each do |subject_id|
            Subject.find(subject_id).lessons.each do |lesson|
              cu.course_user_lessons.create! lesson_id: lesson.id
            end
          end
        end
      end
    end
  end

  def check_and_active_course
    return if @course.errors.details.present?
    if @course.init? and @course.date_start.to_date == Time.zone.today
      if @course.update_attributes status: "in_progress"
        flash[:success] = "Kích hoạt khóa thực tập #{@course.name} thành công."
      else
        flash[:danger] = "Kích hoạt khóa thực tập #{@course.name} thất bại."
      end
    end
  end
end
