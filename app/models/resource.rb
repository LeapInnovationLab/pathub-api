class Resource
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :type, type: String

  belongs_to :user
  belongs_to :milestone
  
  validates_inclusion_of :type, in: [ "file", "url" ]
end