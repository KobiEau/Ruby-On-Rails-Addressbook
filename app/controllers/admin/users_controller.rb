class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :lock, :unlock]
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
  end

  def edit
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
  
    if @user.update(user_params)
      redirect_to admin_users_path, notice:"User updated."
    else
      render :edit, stauts: :unprocessable_entity
    end
  end

  def destroy
    #prevent admin deletion
    if @user == current_user
      redirect_to admin_users_path, alert: "You cannot delete your own account"
      return
    end
    
    #prevent last admin deletion
    if @user.admin? && User.where(role_code:"adm").count == 1
      redirect_to admin_users_path, alert:"Can't delete this admin."
    end

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

  # lock and unlock accounts
  def lock
    @user.lock_account!
    redirect_to admin_users_path, notice: "#{@user.fullname} has been locked."
  end

  def unlock
    @user.unlock_account!
    redirect_to admin_users_path, notice: "#{@user.fullname} has been unlocked."
  end

  private
  def set_user
    @user=User.find(params[:id])
  end
  def user_params
    params.expect(user: [:email, :role_code])
  end

  def new_user_params
    params.expect(user:[:firstname, :lastname, :email,
                  :password, :password_confirmation, :role_code])
  end
end