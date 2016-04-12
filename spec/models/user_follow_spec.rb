require 'rails_helper'

RSpec.describe UserFollow, :type => :model do

  it { is_expected.to have_field(:occurred).of_type(Integer) }

  it { is_expected.to belong_to(:followee).of_type(User).as_inverse_of(:user_followers) }
  it { is_expected.to belong_to(:follower).of_type(User).as_inverse_of(:user_followings) }

  it { is_expected.to validate_presence_of(:followee) }
  it { is_expected.to validate_presence_of(:follower) }
  it { is_expected.to validate_uniqueness_of(:followee).scoped_to(:follower_id) }

  context '# when user follows other users' do
    let(:u1) { create(:user) }
    let(:u2) { create(:user) }
    let(:u3) { create(:user) }

    it 'stores relation' do
      u1.follows u2
      u1.follows u3
      u2.follows u1
      u2.follows u3
      expect(UserFollow.count).to be 4
    end
  end
end