class Admin::ContactsController <Admin::BaseController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  include BulkActions
  def index
    @per_page = (params[:per_page] ||cookies[:admin_contacts_per_page]||5).to_i
    cookies[:admin_contacts_per_page] = @per_page

    #includes(:user)-loads the owner of each contact in same query
    @contacts = Contact.includes(:user)
    @contacts=@contacts.where(
      "contacts.firstname ILIKE :q OR contacts.lastname ILIKE :q
      OR contacts.phone_number ILIKE :q OR users.email ILIKE :q",
      q: "%#{params[:search]}%"
    ).references(:user) if params[:search].present?
 
    @contacts=@contacts.page(params[:page]).per(@per_page)
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      redirect_to admin_contacts_path, notice: "Contact created!"
    else
      @users = User.order(:firstname)
      render :new, status: :unprocessale_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      redirect_to admin_contacts_path, notice: "Contact updated."
    else
      @users= User.order(:firstname)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy
    redirect_to admin_contacts_path, notice: "Contact deleted."
  end

  def bulk_destroy
    super(Contact.all,admin_contacts_path)
  end

  def export_selected
    bulk_export(Contact.all,"contacts",
    ["First Name", "Last Name", "Phone","Owner"],
    ->(c) {[c.firstname,c.lastname,c.phone_number,c.user&.email]})
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    param.expect(contact: [:firstname, :lastname, :phone_number, :category, :user_id])
  end
end
