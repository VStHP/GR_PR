class Registration < ApplicationRecord
	validates :name, presence: true, length: {maximum: 250}
  validates :phone, presence: true, length: {maximum: 12}, format: { with: /0+\d{8,12}/, message: "Số điện thoại định dạng không hợp lệ" }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 250}, format: {with: VALID_EMAIL_REGEX}
  validates :position, presence: true, length: {maximum: 250}
  validates :message, length: {maximum: 5000}
  validates :cv_url, presence: true
  # validate :format_phone
  scope :sort_by_date_new, ->{order(created_at: :desc)}
  mount_uploader :cv_url, UploadCvUploader
  enum status: [:waiting, :accepted, :excepted]

  def format_phone
  	phone.to_i
  end
end
