require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "validations" do
    it "is valid with valid attibutes" do
      expect(user).to be_valid
    end

    it "is invalid without a firstname" do
      invalid_user = build(:user, firstname: nil)
      expect(invalid_user).not_to be_valid
    end

    it "is invalid without a lastname" do
      invalid_user = build(:user, lastname: nil)
      expect(invalid_user).not_to be_valid
    end

    it "is invalid without a email" do
      invalid_user = build(:user, email: nil)
      expect(invalid_user).not_to be_valid
    end

    it "invalid if the same email already exists" do
      invalid_user = build(:user, email: user.email)
      expect(invalid_user).not_to be_valid
    end
  end
end
