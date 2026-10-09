require "rails_helper"

RSpec.describe Contact, type: :model do
  let(:user) { create(:user) }
  describe "validations" do
    it "is valid with valid attributes" do
      contact = build(:contact, user: user)
      expect(contact).to be_valid
    end

    it "is invalid without a firstname" do
      contact = build(:contact, user: user, firstname: nil)
      expect(contact).not_to be_valid
    end
  end
end
