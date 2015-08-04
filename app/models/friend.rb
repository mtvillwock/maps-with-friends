class Friend < ActiveRecord::Base
  has_many :friendships, dependent: :destroy
  has_many :users, through: :friendships

  validates_presence_of :name
  validates_uniqueness_of :name

  # before_destroy :destroy_dependents

  # def destroy_dependents
  #   self.friendships.destroy_all
  # end
end
