require "rails_helper"

RSpec.describe ShopOwner, type: :model do
  subject { create :shop_owner }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of :first_name }

  it { is_expected.to validate_presence_of :last_name }

  it { is_expected.to validate_presence_of :email }

  it { is_expected.to validate_uniqueness_of :email }

  it { is_expected.to have_one(:shop) }
end
