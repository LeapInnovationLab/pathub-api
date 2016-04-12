class TopicFollow
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  belongs_to :user, inverse_of: :followings
  belongs_to :topic, inverse_of: :followers

end