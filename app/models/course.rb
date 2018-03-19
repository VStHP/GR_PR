class Course < ApplicationRecord
  # attr_accessor :subject_ids
  # attr_accessor :user_ids

  belongs_to :user
  has_many :links
  has_many :course_subjects
  has_many :subjects, through: :course_subjects
  has_many :course_users
  has_many :users, through: :course_users

  validates :id, length: {minimum: 4, maximum: 20}, presence: true, uniqueness: {case_sensitive: false}
  validates :name, length: {maximum: 250}, presence: true, uniqueness: {case_sensitive: false}
  validates :description, length: {maximum: 5000}
  validates :program, length: {maximum: 250}, presence: true
  validates :language, length: {maximum: 250}, presence: true
  validates :date_start, presence: true
  validate :datestart_less_than_today, if: :date_start?

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  scope :filter_by, ->(type){where status: type if type}

  enum status: [:init, :in_progress, :finish, :block]

  mount_uploader :avatar, AvatarCourseUploader
  mount_uploader :banner, BannerCourseUploader

  def self.cron_active_course
     Course.all.each do |course|
      if course.date_start.today?
        course.update_attributes status: "in_progress", date_start: Time.zone.now
      end
    end
  end

  private

  def datestart_less_than_today
    return unless status === "init"
    errors.add :date_start, "Ngày bắt đầu không nằm ở quá khứ" if date_start.to_date < Time.zone.today
  end
end
