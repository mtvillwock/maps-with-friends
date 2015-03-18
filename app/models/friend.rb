class Friend < ActiveRecord::Base
  has_and_belongs_to_many :friendships, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name

  # before_destroy :destroy_dependents

  # def destroy_dependents
  #   self.friendships.destroy_all
  # end
end
