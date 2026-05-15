class Admin::UsersController < Admin::BaseController

  include BulkActions
  def index
    # includes(:role) — loads role data in same query,prevents N+1 query
    @users = User.includes(:role).order(created_at: :desc)

    @per_page = (params[:per_page] || cookies[:admin_users_per_page] || 10).to_i
    cookies[:admin_users_per_page] = @per_page
    @users = @users.where(
      "firstanme ILIKE ? OR lastname ILIKE? OR email ILIKE?",
      "%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%"
    )if params[:search].present?
    
    @users = @users.where(role_code: params[:role_filter]) if params[:role_filter].present?
    @users = @users.page(params[:page]).per(@per_page)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(new_user_params)

    if @user.save
      redirect_to admin_users_path, notice:"User created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @user = User.new
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice:"User updated."
    else
      render :edit, stauts: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted"
  end

  def bulk_destroy
    super(User.all,admin_users_path)
  end

  def export_selected
    bulk_export(User.all,"users",
    ["First Name", "Last Name", "Email", "Role", "Joined"],
    ->(u) {[u.firstname, u.lastname, u.email, u.role_code,
    u.created_at.strftime("%b %d, %Y")]})
  end

  private

  def user_params
    params.expect(user: [:email, :role_code])
  end

  def new_user_params
    params.expect(user:[:firstname, :lastname, :email,
                  :password, :password_confirmation, :role_code])
  end
end