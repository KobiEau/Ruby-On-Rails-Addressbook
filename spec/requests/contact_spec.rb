require "rails_helper"

RSpec.describe "Contacts", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "GET /contacts" do
    before { sign_in user }
    it "only returns the current user's contacts" do
      contact = create(:contact, user: user)
      contact2 = create(:contact, user: other_user, firstname: "Test2", phone_number: "0234526372")
      get contacts_path
      puts response.headers["Location"]
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(contact.firstname)
      expect(response.body).not_to include(contact2.firstname)
    end
  end

  describe "POST /contacts" do
    before { sign_in user }
    context "with valid params" do
    it "creates a new contact" do
       expect {
        post contacts_path, params: { contact: attributes_for(:contact) }
      }.to change { Contact.count }.by(1)
    end

    it "redirects after creating" do
      post contacts_path, params: { contact: attributes_for(:contact) }
      expect(response).to have_http_status(:found)
    end
    end

    context "with invalid params" do
      it "returns 422" do
        post contacts_path, params: { contact: { firstname: "", lastname: "", phone_number: "", category: "" } }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PATCH /contacts" do
    
  end

  describe "DELETE /contacts" do
    before { sign_in user } 

    it "decreseas the contact count by 1" do
      contact = create(:contact, user: user)
      expect {
        delete contact_path(contact)
    }.to change { Contact.count }.by(-1)
    end

     it "redirects after creating" do
      contact = create(:contact, user: user)
      delete contact_path(contact)
      expect(response).to have_http_status(:found)
    end

    it "prevents User A from deleting user B's contact" do
      contact2 = create(:contact, user: other_user, firstname: "Test2", phone_number: "0234526372")
       expect {
        delete contact_path(contact2)
      }.not_to change { Contact.count }
    end
  end
end
