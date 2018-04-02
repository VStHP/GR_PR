class Subject < ApplicationRecord
  has_many :tasks
  has_many :course_user_tasks, through: :tasks
  has_many :links
  has_many :course_subjects
  has_many :courses, through: :course_subjects
  has_many :course_users, through: :courses

  validates :id, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 4, maximum: 20}
  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 250}
  validates :description, length: {maximum: 5000}
  validates :day_on_learn, presence: true, numericality: { other_than: 0 }
  # validates :avatar, length: {maximum: 250}

  scope :filter_block, ->{where status: "block"}
  scope :filter_active, ->{where status: "active"}

  accepts_nested_attributes_for :tasks, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  mount_uploader :avatar, AvatarSubjectUploader
  enum status: [:active, :block]

  require 'csv'

  private

  def self.to_csv(options = {})
    desired_columns = ["id", "name", "day_on_learn", "status", "description" ]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |subject|
        csv << subject.attributes.values_at(*desired_columns)
      end
    end
  end

  def self.import(file)
    spreadsheet = Subject.open_spreadsheet(file)
    header = spreadsheet.row(1).map(&:downcase)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      subject = Subject.find_by(id: row["id"]) || Subject.new()
      subject.attributes = row.to_hash
      subject.save!
    end
  end

  def self.import_task(file)
    spreadsheet = Subject.open_spreadsheet(file)
    header = spreadsheet.row(1).map(&:downcase)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      task = Task.find_by(id: row["id"]) || Task.new()
      task.attributes = row.to_hash
      task.save!
    end
  end

  def self.import_link(file)
    spreadsheet = Subject.open_spreadsheet(file)
    header = spreadsheet.row(1).map(&:downcase)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      link = Link.find_by(id: row["id"]) || Link.new()
      link.attributes = row.to_hash
      link.save!
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
