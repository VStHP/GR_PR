class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  scope :filter_by, ->(type){where permission: type if type}
  enum permission: [:trainee, :trainer, :admin]
  enum gender: [:male, :female]
  enum status: [:active, :block]
end
