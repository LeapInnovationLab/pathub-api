class Comment
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  # include ApiModel

  field :content, type: String

  belongs_to :pathway
  belongs_to :user

  validates_presence_of :user, :pathway, on: :create
  validates_presence_of :content

  # after_create :notify_members

  # override
  # def to_json_api(options={})
  #   result = super(except: [:id]).merge(commentId: id)
  #   result.merge!( { user: user.to_json_api(except: [:avatar_2x, :user_id]) } )
  #   result
  # end

  # def data_to_push_for platform=1
  #   data = {}

  #   if self.user_id == self.post.user_id
  #     tit = "#{self.user.first_name} commented on his own post in #{self.post.group.name}"
  #   else
  #     tit = "#{self.user.first_name} commented on #{post.title} in #{self.post.group.name}"
  #   end

  #   if platform == 1  # Android      
  #     data = {
  #       notificationType: Bundle::PushNotification::NEW_COMMENT,
  #       title: tit,
  #       text: self.content.truncate(30),
  #       postId: self.post_id.to_s,
  #       postType: self.post.type,
  #       userId: self.user_id.to_s, 
  #       image: self.user.avatar_url(:thumb)
  #     }
  #   elsif platform == 2  # iOS
  #     data = {
  #       notificationType: Bundle::PushNotification::NEW_COMMENT,
  #       title: tit,
  #       postId: self.post_id.to_s,
  #       postType: self.post.type,
  #       userId: self.user_id.to_s, 
  #     }
  #   end
  #   data        
  # end

  private

  # def notify_members
  #   members = post.comments.collect{|c| c.user_id} # members who commented on the post
  #   members << post.user_id # add the author
  #   members.delete user_id
  #   members.uniq!
  #   members.each do |uid| 
  #     Bundle::PushNotification.push uid, self
  #   end
  # end
end