class RegistrationMailer < ApplicationMailer
	default from: "it_stCompany@gmail.com"

  def send_mail params
    @params = params
    mail(to: params[:registration][:email], subject: "Registry Internship - IT stCompany")
  end

  def accept_mail params
  	@params = params
  	mail(to: params[:mail], subject: "Dang ky thanh cong - IT stCompany")
  end
end
