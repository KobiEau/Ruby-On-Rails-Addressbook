class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update edit_email update_email edit_password update_password danger destroy]
 
  def show
  end

  def edit
  end
  
  def update
     if @user.update_without_password(profile_params)
      redirect_to account_path, notice: "Profile updated"
     else
      render :edit, status: :unprocessable_entity
     end
  end
  
  def edit_email
  end

  def update_email
    unless @user.valid_password?(params[:user][:current_password])
      flash.now[:alert] = "Current password incorrect"
      return render :edit_email, status: :unprocessable_entity
    end

    if @user.update(email_params)
      redirect_to account_path, notice: "Email updated"
    else
      render :edit_email, status: :unprocessable_entity
    end
  end
  
  def edit_password
   
  end

  def update_password
    unless @user.valid_password?(params[:user][:current_password])
      flash.now[:alert] = "Current password is incorrect"
      return render :edit_password, status: :unprocessable_entity
    end
    
    if @user.update(password_params)
      redirect_to account_path, notice: "Password updated successfully"
    else
      render :edit_password, status: :unprocessable_entity
    end
  end


  def danger
        
  end

  def destroy
    unless @user.valid_password?(params[:user][:current_password])
      flash[:alert] = "Incorrect Password"
      return redirect_to danger_account_path
    end

    sign_out(@user)
    @user.destroy
    redirect_to root_path, notice: "Account deleted"
  end

  private
  def set_user
    @user = current_user
  end
  
  def email_params
    params.require(:user).permit(:email)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def profile_params
    params.require(:user).permit(:firstname, :lastname)
  end
end
