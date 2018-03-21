class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound do |exception|
    @error_message = exception.model
    flash[:danger] = "Không tìm thấy #{@error_message}"
    redirect_to root_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = "Không tìm thấy url"
    redirect_to main_app.root_url
  end

  def allow_admin
    return if current_user.admin?
    flash[:danger] = "Không tìm thấy url"
    redirect_to main_app.root_url
  end
end
