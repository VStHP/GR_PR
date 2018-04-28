class RegistrationsController < ApplicationController
	def create
		@registration = Registration.new(registration_params)
		if @registration.save 
			@mes_success = " create successfully"
		else
			@mes_danger = "khong dc"
		end
	end

	private 
	def registration_params
		params.require(:registration).permit :name, :email, :phone, :position, :message, :cv_url
	end
end
