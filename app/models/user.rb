require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates_presence_of :username, :email, :password_hash
  validates_uniqueness_of :username, :email, :password_hash

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
