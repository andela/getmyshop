require 'rails_helper'

RSpec.describe ShopOwner, type: :model do
  subject { create :shop_owner }

  it { is_expected.to be_valid }

  it { should validate_presence_of :first_name }

  it { should validate_presence_of :last_name }

  it { should validate_presence_of :email }

  it { should validate_uniqueness_of :email }

  it { should have_one(:shop) }
end
