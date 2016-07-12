require "rails_helper"

RSpec.describe Shop, type: :model do
  subject { create :shop }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of :name }

  it { is_expected.to validate_presence_of :url }

  it { is_expected.to have_many(:products) }

  it { is_expected.to belong_to(:shop_owner) }
end
