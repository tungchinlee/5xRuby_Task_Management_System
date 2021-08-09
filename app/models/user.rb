class User < ApplicationRecord
  has_secure_password
  validates :email, :name, presence: true, uniqueness: true
  has_many :tasks, dependent: :destroy

  before_destroy :last_admin, prepend: true

  enum role:{
    user: 0,
    admin: 1
  }

  def last_admin
    throw :abort if User.admin.count == 1
  end
end
