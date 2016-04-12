require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) { create(:topic) }
  let(:john) { create(:user, first_name: 'John') }
  let(:jane) { create(:user, first_name: 'Jane') }

  it { is_expected.to have_fields(:name).of_type(String) }

  it { is_expected.to have_many(:followers).as_inverse_of(:topic).of_type(TopicFollow) }
  it { is_expected.to have_many(:posts)}  
  it { is_expected.to have_and_belong_to_many(:child_topics).of_type(Topic) }
  it { is_expected.to have_and_belong_to_many(:parent_topics).of_type(Topic) }

end