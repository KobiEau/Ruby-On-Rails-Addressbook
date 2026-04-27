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

  def import
  end

  def import_create
    file = params[:file]

    # no csv file uploaded?
    unless file&.content_type=="text/csv"
    redirect_to account_path, alert:"Please upload a valid CSV file". 
    return
    end
    
    imported = 0
    failed=[]

    CSV.foreach(file.path, headers: true) do |row|
      contact = Current.user.contacts.build(
        firstname: row["First Name"]&.strip,
        lastname: row["Last Name"]&.strip,
        phone_number: row["Phone Number"]&.strip
      )

      if contact.save
        imported += 1
      else
        failed << $INPUT_LINE_NUMBER
      end
    end
    
    message = "#{imported} contact(s) imported successfully."
    message += " #{failed.size} row(s) failed (lines: #{failed.join(', ')})." if failed.any?

    redirect_to contacts_path, notice: message
  end

  def export_selected
    contacts = if params[:ids].present?
            Current.user.contacts.where(id: params[:ids])
    elsif params[:search].present?
      Current.user.contacts.where(
        "firstname ILIKE ? OR lastname ILIKE ?",
        "%#{params[:search]}%", "%#{params[:search]}%"
      )
    else
      Current.user.contacts.none
    end 

    if contacts.empty?
      return redirect_to contacts_path, alert: "No contacts selected to export."
    end

    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["First Name", "Last Name", "Phone Number"]
      contacts.each do |contact|
        csv << [contact.firstname, contact.lastname, contact.phone_number]
      end
    end

    send_data csv_data,
              filename: "contacts-export-#{Date.today}.csv",
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
