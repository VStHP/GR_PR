class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound do |exception|
    @error_message = exception.model
    flash[:danger] = "Không tìm thấy #{@error_message}"
    redirect_to root_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    @error_message = I18n.t "company_mailer.fail"
    redirect_to main_app.root_url
  end
end
