class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  def index
    @contacts = if params[:search].present?
      Contact.where("firstname ILIKE ? OR lastname ILIKE ?", "%#{params[:search]}%","%#{params[:search]}")
    else
      Contact.all
    end
  end
  
  def show
  end
  
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
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

  private
  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.expect(contact:[:firstname, :lastname, :phone_number])
  end
end
