class IntroduceController < ApplicationController

  layout "layout_introduce/introduce"

  def index
  	@registration = Registration.new
    @company = Company.first
  end
  def new

  end
  def show

  end
  def create
  	@registration = Registration.new(registration_params)
    if @registration.save
      redirect_to root_path
    else
      render :index
    end
  end
  private

  def set_register
  	@register = Register.find(params[:id])
  end

  def registration_params
    params.require(:registration).permit(:name, :email, :phone, :position, :message, :cv_url)
  end
end
