class RegistrationsController < ApplicationController
	load_and_authorize_resource param_method: :registration_params, only: %i(index create update)
	def create
		if @registration.save 
			@mes_success = " create successfully"
			RegistrationMailer.send_mail(params).deliver_now
		else
			@mes_danger = "khong dc"
		end
	end

	def index
	end

	def update
		if @registration.update_attributes status: params[:registration][:status]
			@mes_success = "successfully"
		else
			@mes_danger = " KHong Thanh Cong"
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
