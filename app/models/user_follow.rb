class UserFollow
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  belongs_to :followee, class_name: 'User', inverse_of: :user_followers
  belongs_to :follower, class_name: 'User', inverse_of: :user_followings

  validates_presence_of :followee, :follower
  validates_uniqueness_of :followee, scope: :follower_id, message: 'user already in the followings list'
end