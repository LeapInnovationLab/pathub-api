class Topic
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :name, type: String

  # has_many :posts
  has_many :followers, class_name: 'TopicFollow', inverse_of: :topic
  has_and_belongs_to_many :child_topics, class_name: "Topic", inverse_of: :parent_topics
  has_and_belongs_to_many :parent_topics, class_name: "Topic", inverse_of: :child_topics
    
end