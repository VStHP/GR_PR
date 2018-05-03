class Company < ApplicationRecord
  validates :name, length: {maximum: 250}, presence: true
  validates :description, length: {maximum: 5000}, presence: true
  validates :address, length: {maximum: 250}, presence: true
  validates :city, length: {maximum: 250}, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 250}, format: {with: VALID_EMAIL_REGEX}
  validates :phone, length: {maximum: 12},format: { with: /0+\d{8,12}/, message: "Số điện thoại định dạng không hợp lệ" }, presence: true


  mount_uploader :image_1, CompanyImage1Uploader
  mount_uploader :image_2, CompanyImage2Uploader
  mount_uploader :image_3, CompanyImage3Uploader
  mount_uploader :image_4, CompanyImage4Uploader
end
