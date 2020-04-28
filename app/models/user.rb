class User < ApplicationRecord
  validates :name, presence: true, length:{maximum:30}
  validates :email, presence: true, length:{maximum:50}
              # format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  validates :password, presence: true, length:{minimum:6}

  before_destroy :do_not_destroy_last_admin
  has_many :tasks, dependent: :destroy
  has_secure_password

  private
  def do_not_destroy_last_admin
    throw(:abort) if User.where(admin: true).count <=1 && self.admin?
  end
end
