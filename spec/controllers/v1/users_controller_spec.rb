require 'rails_helper'
require 'shared_example_for_api'

RSpec.describe V1::UsersController, type: :controller do

  describe 'POST #create' do
    let(:user_attributes) { FactoryGirl.attributes_for :user, :brand_new }
    
    context 'when is valid email and password' do
      before { post :create, camelize_keys_for(user_attributes) }
      
      it 'returns authentication token and user id' do
        uid = response.headers['X-QUESEE-USERID'] 
        expect(uid).to be_a String      
        expect(response.headers['X-QUESEE-AUTHTOKEN']).to be_a String
        expect(uid).to eq User.last.id.to_s
      end

      it { is_expected.to respond_with :ok } 
    end

    context 'when is invalid email and password' do
      before { post :create, camelize_keys_for(user_attributes.merge({email: 'invalidemail', first_name: ''})) }
      
      it 'returns error messages' do
        expect(json_response).to be_a Hash      
        expect(json_response[:errors]).not_to be_nil
      end

      it { is_expected.to respond_with :bad_request } 
    end

    context 'when using facebook' do
      let(:fb_user_attributes) {  FactoryGirl.attributes_for(:user_from_facebook, :brand_new) }
      before { post :create, camelize_keys_for(fb_user_attributes) }

      it 'returns authenciation token and user id' do
        uid = response.headers['X-QUESEE-USERID'] 
        expect(uid).to be_a String      
        expect(response.headers['X-QUESEE-AUTHTOKEN']).to be_a String
        expect(uid).to eq User.last.id.to_s        
      end

      it { is_expected.to respond_with :ok } 
    end
  end
end