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
        redirect_to account_path, notice: "Account updated"
      else
        render :edit,status: :unprocessable_entity
      end
  end

  def edit_password
  end

  def update_password
    @user = Current.user

    unless @user.authenticate(params[:current_password])
      flash.now[:alert] = "Current password is incorrect"
      return render :edit_password, status: :unprocessable_entity
    end
    
    if @user.update(password_params)
      redirect_to account_path, notice: "Password updated successfully"
    else
      flash.now[:alert] = "Incorrect credentials"
      render :edit_password, status: :unprocessable_entity
    end

  end

  def destroy
    Current.user.destroy
    reset_session
    redirect_to root_path, notice: "Account deleted"
  end

  private
  
  def user_params
    params.require(:user).permit(:firstname, :lastname, :email_address)
  end

  def password_params
    params.require(:user).permit(:password,:password_confirmation)
  end
end
