require 'rails_helper'

RSpec.describe User, type: :model do
  
  it 'saves basic user' do
    user = create :user
    expect(user).to be_persisted
  end

  it 'saves facebook user' do
    fb_user = create :fb_user
    expect(fb_user).to be_persisted
  end

  it 'tests' do
    binding.pry    
  end
end