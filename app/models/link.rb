class Link < ApplicationRecord
  belongs_to :course, optional: true
  belongs_to :subject, optional: true
  belongs_to :lesson, optional: true
  validates :name, presence: true, length: {maximum: 250}
  validates :link, presence: true, length: {maximum: 250}
  validates :description, length: {maximum: 5000}
end
