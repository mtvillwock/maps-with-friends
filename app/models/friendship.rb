class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  validates_presence_of :user_id, :friend_id
  validates_presence_of :user_id, :friend_id
end
