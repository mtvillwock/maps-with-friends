class User < ActiveRecord::Base
  has_many :friends

  validates_presence_of :username, :email, :password_hash
  validates_uniqueness_of :username, :email, :password_hash
end
