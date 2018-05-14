require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to(:votable) }
  it { should belong_to(:user) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:user_id) }
end
