class Relationship < ActiveRecord::Base
  attr_accessible :followed_id

  belongs_to :follower, :foreign_key => "follower_id", :class_name => "User"
  belongs_to :followed, :foreign_key => "followed_id", :class_name => "User"

  validates_presence_of :followed_id, :follower_id
end
