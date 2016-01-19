require "rails_helper"

RSpec.describe User, type: :model do
  it "is a valid factory" do
    expect(build(:regular_user)).to be_valid
  end

  let(:user) { build(:regular_user) }

  describe "instance methods" do
    context "respond to instance method calls" do
      it { expect(user).to respond_to(:first_name) }
      it { expect(user).to respond_to(:last_name) }
      it { expect(user).to respond_to(:email) }
      it { expect(user).to respond_to(:phone) }
      it { expect(user).to respond_to(:activation_token) }
      it { expect(user).to respond_to(:active_status) }
      it { expect(user).to respond_to(:password_digest) }
    end

    context "#assign_token" do
      it "generates and assigns the activation token to user instance" do
        user.assign_token
        expect(user.active_status).to be_falsey
        expect(user.activation_token).to be_a(String)
        expect(user.activation_token.length).to eq(50)
      end
    end
  end

  describe "ActiveModel Validation" do
    it { expect(user).to validate_presence_of(:first_name) }
    it { expect(user).to validate_presence_of(:last_name) }
    it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to validate_uniqueness_of(:email) }

    it { expect(user).to allow_value("Muhammed Alibaba").for(:first_name) }
    it { expect(user).to allow_value("emmanuel.chigbo@andela.com").for(:email) }
    it { expect(user).not_to allow_value("emmanuel.chigbo@andela").for(:email) }
    it { expect(user).not_to allow_value("emmanuel.chigbo").for(:email) }
    it { expect(user).not_to allow_value("@.").for(:email) }
  end

  describe "ActiveModel Association" do
    # it do
    #   expect(airport).to have_many(:flights).
    #     with_foreign_key(:origin_airport_id)
    # end
  end

  # it { expect(user).to have_secure_password }
end
