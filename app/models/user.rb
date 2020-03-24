class User < ApplicationRecord
  validates :name, presence: true, length:{maximum:30}
  validates :email, presence: true, length:{maximum:50},uniqueness:true,
              format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  validates :password, presence: true, length:{minimum:6}

  has_secure_password
  # mount_uploader :image, ImageUploader
  has_many :tasks
  # has_many :favorites, dependent: :destroy
  # has_many :favorite_tasks, through: :favorites, source: :feed
end
