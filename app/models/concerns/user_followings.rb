module UserFollowings
  extend ActiveSupport::Concern

  included do    
    has_many :topic_followings, class_name: 'TopicFollow', inverse_of: :user
    has_many :user_followers, class_name: 'UserFollow', inverse_of: :followee, dependent: :destroy
    has_many :user_followings, class_name: 'UserFollow', inverse_of: :follower, dependent: :destroy
    has_many :pathway_followings, class_name: 'PathwayFollow', inverse_of: :user, dependent: :destroy
  end

  def follows o
    if o.is_a? User
      self.user_followings.create followee_id: o.id
    elsif o.is_a? Topic
      self.topic_followings.create topic_id: o.id
    elsif o.is_a? Pathway
      self.pathway_followings.create pathway_id: o.id
    end
  end

  def unfollows o
    if o.is_a? User
      self.user_followings.destroy_all followee_id: o.id
    elsif o.is_a? Topic
      self.topic_followings.destroy_all topic_id: o.id
    elsif o.is_a? Pathway
      self.pathway_followings.destroy_all pathway_id: o.id
    end
  end

  def followers
    self.user_followers.collect {|f| f.follower }
  end

  [:user, :topic, :pathway].each do |obj_type|
    define_method("#{obj_type}_follows".to_sym) do
      if obj_type == :user
        self.user_followings.collect {|f| f.followee }
      elsif obj_type == :topic
        self.topic_followings.collect {|f| f.topic }
      elsif obj_type == :pathway
        self.pathway_followings.collect {|f| f.pathway }
      end
    end
  end  
end