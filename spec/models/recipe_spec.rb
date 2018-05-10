require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:pictures) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:ingredients) }
  it { is_expected.to validate_presence_of(:directions) }
end
