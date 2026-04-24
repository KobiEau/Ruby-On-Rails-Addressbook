 require "csv"
class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  def index
  @contacts = if params[:search].present?
  Current.user.contacts.where("firstname ILIKE ? OR lastname ILIKE ?",
  "%#{params[:search]}%", "%#{params[:search]}%")
  else
    Current.user.contacts
  end

  @per_page = (params[:per_page] || 10).to_i
  @contacts = @contacts.page(params[:page]).per(@per_page)
  end
  
  def show
    @user = Current.user
  end
  
  def new
    @contact = Contact.new
  end

  def create
    @contact = Current.user.contacts.build(contact_params)
    if @contact.save
      redirect_to contacts_path, notice: "Contact created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      redirect_to @contact, notice: "Contact updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy
    redirect_to contacts_path, notice: "Contact deleted successfully"
  end

  # Exporting contacts
  def export
    contacts = Current.user.contacts

    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["Firt Name", "Last Name", "Phone Number"]
      contacts.each do |contact|
        csv << [contact.firstname, contact.lastname,contact.phone_number]
      end
    end

    send_data csv_data,
              filename: "contacts-#{Date.today}.csv",
              type:"text/csv"
  end

  private

  def set_contact
    @contact =Current.user.contacts.find(params[:id])
  end

  def contact_params
    params.expect(contact:[:firstname, :lastname, :phone_number])
  end
end
