require "rails_helper"

RSpec.describe Shop, type: :model do
  subject { create :shop }

  it { is_expected.to be_valid }

  it { should validate_presence_of :name }

  it { should validate_presence_of :url }

  it { should have_many(:products) }

  it { should belong_to(:shop_owner) }
end
