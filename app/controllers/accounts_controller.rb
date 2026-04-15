class AccountsController < ApplicationController
  before_action :require_authentication

  def show
    @user = Current.user
  end

  def edit
    @user=Current.user
  end

  def update
    @user = Current.user

    if @user.update(user_params)
      redirect_to contacts_path,notice: "Account updated successfully"
    
    else
      render :edit, status: :unprocessable_entity
    end
    
  end

  def destory
    Current.user.destroy
    reset_session
    redirect_to root_path, notice: "Account deleted"
  end

  private
  
  def user_params
    params.require(:user).permit(:firstname, :lastname, :email_address, :password, :password_confirmation)
  end
end
