class Milestone
  include Mongoid::Document

  field :name, type: String

  belongs_to :pathway
  has_many :resources
end