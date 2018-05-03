class Admin::CompaniesController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def edit
  end

  def update
    if @company.update_attributes params_company
      @mes_success = "Cập nhật thông tin công ty thành công"
    else
      @mes_danger = "Cập nhật thông tin công ty thất bại"
    end
  end

  private

  def params_company
    params.require(:company).permit :name, :email, :phone, :address, :city, :description,
      :image_1, :image_2, :image_3, :image_4
  end
end
