class Admin::ContactsController <Admin::BaseController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    #includes(:user)-loads the owner of each contact in same query
    @contacts = Contact.includes(:user)
    @contacts=@contacts.where(
      "firstname ILIKE? OR lastname ILIKE?",
      "%#{params[:search]}%","%#{params[:search]}%"
    )if params[:search].present?

    @contacts=@contacts.order(firstname: :asc)
  end

  def show
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      redirect_to admin_contact_path(@contact), notice: "Contact updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy
    redirect_to admin_contacts_path, notice: "Contact deleted."
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    param.expect(contact: [:firstname, :lastname, :phone_number, :category])
  end
end
