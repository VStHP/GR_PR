class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 250},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :name, presence: true, length: {maximum: 250}
  validates :phone, length: {minimum: 10, maximum: 15}, if: :phone?
  validates :university, length: {maximum: 250}
  validates :program, length: {maximum: 250}
  validates :password, presence: true, length: {minimum: 6, maximum: 50}, allow_nil: true
  validate :birthdate_less_than_today, if: :birthday?


  scope :filter_by, ->(type){where permission: type if type}
  scope :filter_by_active, -> {where status: "active"}
  scope :filter_by_block, -> {where status: "block"}
  enum permission: [:trainee, :trainer, :admin]
  enum gender: [:male, :female]
  enum status: [:active, :block]

  mount_uploader :avatar, AvatarUploader

  def birthdate_less_than_today
    if birthday.present?
      errors.add :birthday, "Ngày sinh không hợp lệ" if birthday > Time.zone.today-365
    end
  end
end
