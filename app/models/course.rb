class Course < ApplicationRecord
  # attr_accessor :subject_ids
  # attr_accessor :user_ids

  belongs_to :user
  has_many :links
  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects
  has_many :course_users
  has_many :course_user_tasks, through: :course_users
  has_many :users, through: :course_users

  validates :id, length: {minimum: 4, maximum: 20}, presence: true, uniqueness: {case_sensitive: false}
  validates :name, length: {maximum: 250}, presence: true, uniqueness: {case_sensitive: false}
  validates :description, length: {maximum: 5000}
  validates :program, length: {maximum: 250}, presence: true
  validates :language, length: {maximum: 250}, presence: true
  validates :date_start, presence: true
  # validates :banner, length: {maximum: 250}
  # validates :avatar, length: {maximum: 250}
  validate :datestart_less_than_today, if: :date_start?

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  scope :filter_by, ->(type){where status: type if type}

  enum status: [:init, :in_progress, :finish, :block]

  mount_uploader :avatar, AvatarCourseUploader
  mount_uploader :banner, BannerCourseUploader

  require 'csv'

  def self.cron_active_course
     Course.all.each do |course|
      if course.date_start.today?
        course.update_attributes status: "in_progress", date_start: Time.zone.now
      end
    end
  end

  private

  def self.to_csv(options = {})
    desired_columns = ["id", "name", "user_id", "program", "language", "status", "date_start", "date_end", "description" ]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |course|
        csv << course.attributes.values_at(*desired_columns)
      end
    end
  end

  def self.import(file)
    spreadsheet = Course.open_spreadsheet(file)
    header = spreadsheet.row(1).map(&:downcase)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      course = Course.find_by(id: row["id"]) || Course.new()
      course.attributes = row.to_hash
      course.save!
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

  def datestart_less_than_today
    return unless status === "init"
    errors.add :date_start, "Ngày bắt đầu không nằm ở quá khứ" if date_start.to_date < Time.zone.today
  end
end
