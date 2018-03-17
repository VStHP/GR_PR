class Task < ApplicationRecord
  belongs_to :subject
  has_many :links

  validates :name, length: {maximum: 250}, presence: true, uniqueness: {case_sensitive: false}
  validates :description, length: {maximum: 5000}
  validates :youtube_url, length: {maximum: 250}

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

end
