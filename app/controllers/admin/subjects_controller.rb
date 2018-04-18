class Admin::SubjectsController < ApplicationController
  load_and_authorize_resource param_method: :params_subject
  after_action :add_course_user_lesson, only: :update
  before_action :set_subject, only: :export_subject

  def index
    if params[:type]
      @subjects = Subject.filter_block
    else
      @subjects = Subject.filter_active
    end
  end

  def new
    @subject = Subject.new
    1.times { @subject.lessons.build}
    1.times { @subject.links.build}
  end

  def create
    if @subject.save
      flash[:success] = "Tạo môn học thành công"
      redirect_to admin_subject_path(@subject)
    else
      flash[:danger] = "Tạo môn học thất bại"
      render :new
    end
  end

  def destroy
    respond_to do |format|
      if @subject.course_subjects.length == 0
        if @subject.destroy
          format.js{@mes_success = "Xóa môn học thành công"}
        else
          format.js{@mes_danger = "Xóa môn học thất bại"}
        end
      else
        format.js{@mes_danger = "Không thể xóa môn học đã tồn tại trong khóa thực tập"}
      end
    end
  end

  def edit; end

  def show
    @courses = @subject.courses
    @lessons = @subject.lessons
  end

  def update
    if @subject.update_attributes params_subject
      flash[:success] = "Cập nhật môn học thành công"
      redirect_to admin_subjects_path
    else
      flash[:danger] = "Không thể cập nhật môn học"
      render :edit
    end
  end

  def change_status
    respond_to do |format|
      if @subject.block?
        if @subject.update_attribute :status, "active"
          format.js{@mes_success = "#{@subject.name} đã được mở khóa"}
        else
          format.js{@mes_danger = "Không thể thay đổi trạng thái môn học"}
        end
      else
        if @subject.update_attribute :status, "block"
          format.js{@mes_success = "#{@subject.name} đã bị khóa"}
        else
          format.js{@mes_danger = "Không thể thay đổi trạng thái môn học"}
        end
      end
    end
  end

  def export
    @subjects = Subject.all
    respond_to do |format|
      format.csv { send_data @subjects.to_csv }
      format.xls
    end
  end

  def export_subject
    @lessons = @subject.lessons
    @links = @subject.links
    respond_to do |format|
      format.xls
    end
  end

  def import
    Subject.import params[:file]
    flash[:success] = "Nhập danh sách môn học từ file thành công"
    redirect_back fallback_location: root_path
  end

  def import_lesson
    Subject.import_lesson params[:file]
    flash[:success] = "Nhập chương cho môn học từ file thành công"
    redirect_back fallback_location: root_path
  end

  def import_link
    Subject.import_link params[:file]
    flash[:success] = "Nhập liên kết mô tả cho môn học từ file thành công"
    redirect_back fallback_location: root_path
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
      lessons_attributes: [:id, :name, :description, :subject_id, :_destroy, :youtube_url])
  end

  def add_course_user_lesson
    @subject.lessons.each do |lesson|
      if lesson.id_previously_changed?
        @subject.course_users.each do |cu|
          cu.course_user_lessons.create! lesson_id: lesson.id
        end
      end
    end
  end
end
