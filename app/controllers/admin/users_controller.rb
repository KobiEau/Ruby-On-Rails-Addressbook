class Admin::UsersController < Admin::BaseController
  def index
    # includes(:role) — loads role data in same query,prevents N+1 query
    @users = User.includes(:role).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
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

  private

  def user_params
    params.require(:user).permit(:email,:role_code)
  end
end