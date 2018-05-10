require 'rails_helper'

RSpec.describe Picture, type: :model do
  it { should belong_to(:recipe) }
  it { is_expected.to validate_presence_of(:file) }
end
