require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do
  let(:order) do
    create :order,
           user: create(:regular_user),
           address: create(:address)
  end
  let(:mail) { OrderMailer.confirmation_email(order, "Play") }
  context "#confirmation_email" do
    it "renders the subject" do
      expect(mail.subject).to eq "Play"
    end

    it "renders receiver's email address" do
      expect(mail.to).to eq [order.user.email]
    end

    it "renders sender's email address" do
      expect(mail.from).to eq ["noreply@getmyshop.herokuapp.com"]
    end
  end
end
