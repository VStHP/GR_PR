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

  require 'csv'

  def birthdate_less_than_today
    if birthday.present?
      errors.add :birthday, "Ngày sinh không hợp lệ" if birthday > Time.zone.today-365
    end
  end

  private

  def self.to_csv(options = {})
    desired_columns = ["id", "name", "email", "permission", "gender", "birthday", "phone", "university", "program", "created_at"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |user|
        csv << user.attributes.values_at(*desired_columns)
      end
    end
  end

  def self.import(file)
    spreadsheet = User.open_spreadsheet(file)
    header = spreadsheet.row(1).map(&:downcase)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      user = User.find_by(id: row["id"]) || User.new(password: "123123", password_confirmation: "123123")
      user.attributes = row.to_hash
      user.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, file_warning: :ignore)
    when ".xls" then Roo::Excel.new(file.path, file_warning: :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, file_warning: :ignore)
    else raise "Unknown file"
    end
  end
end
