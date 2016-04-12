class User
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include UserFollowings  
  # include ApiModel
  # include ActiveModel::SecurePassword

  # Include default devise modules. Others available are:
  # :rememberable, :trackable
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  # field :remember_created_at, type: Time

  ## Trackable
  # field :sign_in_count,      type: Integer, default: 0
  # field :current_sign_in_at, type: Time
  # field :last_sign_in_at,    type: Time
  # field :current_sign_in_ip, type: String
  # field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time  

  ROLES = %i[admin member]
  
  # Fields
  field :first_name, type: String
  field :last_name, type: String
  field :birthday, type: String
  field :gender, type: String  
  field :phone, type: String
  field :username, type: String
  field :provider
  field :uid
  field :role, type: String, default: 'member'
  field :title, type: String
  
  # secure with bcryp
  # field :password_digest, type: String
  # has_secure_password

  # mount_uploader :avatar, AvatarUploader

  # has_many :auth_tokens, dependent: :destroy
  # has_many :posts, dependent: :destroy
  # has_many :comments, dependent: :destroy
  # has_many :verification_tokens, dependent: :destroy
  
  # Validations
  validates_presence_of :first_name, :last_name, :on => :create
  validates_uniqueness_of :username
  validates_format_of :username, with: /\A[a-zA-Z0-9_]+\z/
  
  # Indexes
  index({email: 1},{unique: true})  

  # Hooks
  before_validation :friendly_password, if: 'password.nil? && provider.present? && uid.present?'
  before_validation :generate_username

  # Overide this method when using ActiveJob for delayed jobs
  # def send_devise_notification(notification, *args)
  #   devise_mailer.send(notification, self, *args).deliver_later
  # end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.from_external(external)
    where(provider: external[:provider], uid: external[:uid]).first_or_create do |u|
      u.email = external[:email]
      u.first_name = external[:first_name]
      u.last_name = external[:last_name]
      u.phone = external[:phone]
      u.birthday = external[:birthday]
      u.gender = external[:gender]
      u.remote_avatar_url = external[:avatar]
      u.password =  external[:password]
    end
  end

  # def to_json_api(options={})
  #   api_valid_fields = [:first_name, :last_name, :avatar, :title]
  #   u_data = attributes.select{|k,v| api_valid_fields.include? k.to_sym }
  #   u_data['userId'] = id.to_s unless options[:except].try(:include?, :user_id)
  #   u_data['avatar'] = avatar_url(:thumb) unless options[:except].try(:include?, :avatar)
  #   u_data['avatar_2x'] = avatar_url(:square) unless options[:except].try(:include?, :avatar_2x)
  #   if options[:full]
  #     u_data[:email] = email
  #     u_data[:conversationCount] = conversations.count
  #     u_data[:contactCount] = contacts.count
  #     u_data[:paymentCount] = payments.count
  #     u_data[:billingAddress] = billing.try(:to_json_api)
  #   end
  #   camelize_keys_for u_data  
  # end

  # def reset_password option=VerificationToken::OPT_SMS
  #   verification = self.verification_tokens.create usage: VerificationToken::USAGE_RSTPWD, type: option
  #   verification.token
  # end

  # def update_password_with_token password, token
  #   vt = self.verification_tokens.find_by(usage: VerificationToken::USAGE_RSTPWD)
  #   if vt.present?
  #     errors.add(:password, I18n.t('mongoid.errors.models.verification_token.attributes.token.invalid')) unless vt.token == token
  #   else
  #     errors.add(:password, I18n.t('mongoid.errors.models.verification_token.attributes.token.expired'))
  #   end 
  #   return false unless errors.empty?        
  #   self.assign_attributes password: password
  #   vt.destroy if self.valid?
  #   save
  # end

  # def send_sms_for_phone_verification token
  #   update_attribute(:phone_verification_code, token)
  #   send_sms("Your Quesee verification code is: #{phone_verification_code}") unless phone_verified
  # end

  ROLES.each do |action|
    define_method("#{action}?".to_sym) do
      role == action.to_s
    end
  end

  private

  def friendly_password
    self.password = Devise.friendly_token[0,20]
  end

  def generate_username
    if self.username.nil?
      uname = full_name.downcase.gsub /[^0-9A-Za-z]/, ''

      found_similar = User.where(:username => /^#{uname}/i).only(:username).collect{|u| u.username}
      last_num = found_similar.collect{|n| n.gsub(/^#{uname}/, '').to_i }.sort.last
      uname.concat (last_num + 1).to_s  unless last_num.nil?

      self.username = uname      
    end
  end

end
