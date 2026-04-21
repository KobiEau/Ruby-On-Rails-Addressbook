class AccountsController < ApplicationController
  before_action :require_authentication
  before_action :set_user, only: %i[show edit update edit_password update_password destroy]
  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to account_path, notice: "Account updated"
    else
      render :edit,status: :unprocessable_entity
    end
  end

  def edit_password
   
  end

  def update_password
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
    unless @user.authenticate(params[:current_password])
      flash[:alert] = "Incorrect Password"
      return redirect_to edit_account_path
    end

    @user.destroy
    reset_session
    redirect_to root_path, notice: "Account deleted"
  end

  private
  def set_user
    @user = Current.user
  end
  
  def user_params
    params.require(:user).permit(:firstname, :lastname, :email_address)
  end

  def password_params
    params.require(:user).permit(:password,:password_confirmation)
  end
end
