class RegistrationMailer < ApplicationMailer
	default from: "it_stCompany@gmail.com"

  def send_mail params
    @params = params
    mail(to: params[:registration][:email], subject: "Registry Internship - IT stCompany")
  end

  def accept_mail params
  	@params = paramshotel
  	mail(to: params[:mail], subject: "PHẢN HỒI THỰC TẬP - IT stCompany")
  end

  def except_mail registration
    @registration = registration
    mail(to: registration.email, subject: "PHẢN HỒI THỰC TẬP - IT stCompany")
  end
end
