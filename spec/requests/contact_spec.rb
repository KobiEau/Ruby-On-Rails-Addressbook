require "rails_helper"

RSpec.describe "Contacts", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "GET /contacts" do
    before { sign_in user}
    it "only returns the current user's contacts" do
      contact = create(:contact, user: user)
      contact2 = create(:contact, user: other_user)
      get contacts_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(contact.firstname)
      expect(response.body).not_to include(contact2.firstname)
    end
  end
end
