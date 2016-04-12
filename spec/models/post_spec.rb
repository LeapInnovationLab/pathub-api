require 'rails_helper'

RSpec.describe Post, type: :model do
  it { is_expected.to have_field(:occurred).of_type(Integer) }
  it { is_expected.to have_field(:content).of_type(String) } 
  
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:photos) }
  
  it { is_expected.to validate_presence_of(:user).on(:create) }  
end