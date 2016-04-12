require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to have_field(:occurred).of_type(Integer) }
  it { is_expected.to have_field(:content).of_type(String) }
  
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:post) }

  it { is_expected.to validate_presence_of(:user).on(:create) }
  it { is_expected.to validate_presence_of(:post).on(:create) }
  it { is_expected.to validate_presence_of(:content) }
end