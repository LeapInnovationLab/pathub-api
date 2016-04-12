class PathwayFollow
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  belongs_to :user
  belongs_to :pathway
end