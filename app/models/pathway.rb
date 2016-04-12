class Pathway
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :title, type: String
  field :description, type: String

  belongs_to :user
  has_many :milestones
  has_many :followers, class_name: 'PathwayFollow', inverse_of: :pathway

  validates_presence_of :user, on: :create
end