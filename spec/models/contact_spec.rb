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

    it "is invalid without a lastname" do
      contact = build(:contact, user: user, lastname: nil)
      expect(contact).not_to be_valid
    end

    it "is invalid without a category" do
      contact = build(:contact, category: nil, user: user)
      expect(contact).not_to be_valid
    end

    it "is invalid without a phone_number" do
      contact = build(:contact, phone_number: nil, user: user)
      expect(contact).not_to be_valid
    end

    it "is invalid if the same contacts exists" do
      create(:contact, user: user)
      contact2 = build(:contact, user: user)
      expect(contact2).not_to be_valid
    end
  end
end
