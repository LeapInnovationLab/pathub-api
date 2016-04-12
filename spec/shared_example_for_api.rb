require "set"

[:put, :post, :delete, :get].each do |method|
  RSpec.shared_examples "#{method}_valid_authentication" do |action, attributes|
    context 'when is invalid auth_token' do
      before { send(method, action, attributes ) }
      it { is_expected.to respond_with :unauthorized }  
    end
  end
end