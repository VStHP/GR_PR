class RegistrationsController < ApplicationController
	load_and_authorize_resource param_method: :registration_params, only: %i(index create update)
	def create
		if @registration.save
			@mes_success = "Đăng ký thực tập thành công"
			RegistrationMailer.send_mail(params).deliver_now
		else
			@mes_danger = "Đăng ký thực tập thất bại"
		end
	end

	def index
	end

	def update
		if @registration.update_attributes status: params[:registration][:status]
			@mes_success = "Cập nhật trạng thai bản đăng ký thành công"
			if params[:registration][:status] == "excepted"
				RegistrationMailer.except_mail(@registration).deliver_now
			end
		else
			@mes_danger = "Cập nhật trạng thai bản đăng ký thất bại"
		end
	end

	def accept_action
		RegistrationMailer.accept_mail(params).deliver_now
	end
	private
	def registration_params
		params.require(:registration).permit :name, :email, :phone, :position, :message, :cv_url
	end
end
