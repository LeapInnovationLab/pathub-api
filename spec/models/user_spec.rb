require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  # it { is_expected.to have_field(:occurred).of_type(Integer) }
  # it { is_expected.to have_fields(:first_name, :last_name, :email, :phone, :birthday, :title, :username).of_type(String) }  

  # it { is_expected.to validate_presence_of(:email) }
  # it { is_expected.to validate_presence_of(:username)} 
  # it { is_expected.to validate_presence_of(:first_name) }
  # it { is_expected.to validate_presence_of(:last_name) }
  # it { is_expected.to validate_presence_of(:password) }  
  # it { is_expected.to validate_length_of(:password).within(6..128) }
  # it { is_expected.to validate_uniqueness_of(:email) }
  # it { is_expected.to validate_uniqueness_of(:username) }
  # it { is_expected.to validate_format_of(:username).to_allow("johndoe").not_to_allow(" john doe") }

  # it { is_expected.to have_many(:topic_followings).as_inverse_of(:user).of_type(TopicFollow) }
  # it { is_expected.to have_many(:pathway_followings).as_inverse_of(:user).of_type(PathwayFollow) }
  # it { is_expected.to have_many(:user_followers).as_inverse_of(:followee).of_type(UserFollow) }
  # it { is_expected.to have_many(:user_followings).as_inverse_of(:follower).of_type(UserFollow) }
  # it { is_expected.to have_many(:pathways) }

  # it { is_expected.to have_index_for(email: 1) }
  # it { is_expected.to have_index_for(username: 1) }

  xdescribe '# when ensuring creation with unique usernames' do
    it 'generates a default username after creation' do

      Thread.abort_on_exception=true
      (1..3).each do |n|
        Thread.new do
          (0..4).each do |i|
            begin
              # instead of User.create
              User.safetly_create email: "jondoe#{i}-#{n}@karmic.com", first_name: 'John', last_name: 'Doe', password: 'admin123', title: "thread #{n}"
            rescue 
              pp $!
            end
            sleep(n)
          end
        end

        sleep(1)
      end
    
    end    
  end


  it 'saves basic user' do
    user = create :user
    expect(user).to be_persisted
  end

  it 'saves facebook user' do
    fb_user = create :fb_user
    expect(fb_user).to be_persisted
  end
  
  context '# when following users' do
    let(:u1) { create(:user) }
    let(:u2) { create(:user) }

    before do
      u1.follows user
      u1.follows u2
      u2.follows user
    end

    it 'user has a list of user followings' do
      expect(u1.user_follows.count).to be 2
      expect(u2.user_follows.count).to be 1
    end

    it 'followed users has a list of followers' do
      expect(user.followers.count).to be 2
      expect(u2.followers.count).to be 1
    end

    it 'user can unfollow users' do
      u1.unfollows user
      u1.reload
      expect(u1.user_follows.count).to be 1
    end

    it { expect(user).to respond_to(:followers) }    
    it { expect(user).to respond_to(:user_followings) }    
  end

  context '# when following topics' do
    let(:education) { create(:topic) }
    let(:employment) { create(:topic, name: 'Employment') }

    before do
      user.follows education
      user.follows employment
      user.reload
    end

    it 'user has topic followings' do
      expect(user.topic_follows.count).to be 2
      expect(user.topic_follows.first).to be_a Topic
    end

    it 'topic has followers' do
      expect(education.followers.count).to be 1
      expect(employment.followers.count).to be 1
    end

    it 'user can unfollow a topic' do
      user.unfollows education
      user.reload
      expect(user.topic_follows.count).to be 1
    end

    it { expect(user).to respond_to(:topic_followings) }
  end

  context '# when following pathways' do
    let(:p1) { create(:pathway) } 
    let(:p2) { create(:pathway, title: 'How to become an investment banker' ) }

    before do 
      user.follows p1
      user.follows p2
      user.reload
    end

    it 'user has pathway followings' do
      expect(user.pathway_follows.count).to be 2
      expect(user.pathway_follows.first).to be_a Pathway
    end

    it 'pathway has followers' do
      expect(p1.followers.count).to be 1
      expect(p2.followers.count).to be 1      
    end

    it 'user can unfollow a pathway' do
      user.unfollows p1
      user.reload
      expect(user.pathway_follows.count).to be 1
    end

    it { expect(user).to respond_to(:pathway_followings) }
  end
end