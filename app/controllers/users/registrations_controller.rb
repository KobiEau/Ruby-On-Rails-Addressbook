class Users::RegistrationsController < Devise::RegistrationsController
  #handling  password change separately other fields
  def update
    if params[:user][:current_password].present?
      super
    else
      @user = current_user
      if @user.update_without_password(update_params)
        redirect_to edit_user_registration_path, notice: "Account Profile updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end 
  
  def after_sign_up_path_for(resource)
    #where to go after signing up - contacts index
    contacts_path
  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end

  private

  def update_params
    params.require(:user).permit(:firstname, :lastname)
  end

  def account_update_params
    params.require(:user).permit(:email, :firstname, :lastname, :current_password, :password, :password_confirmation)
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :firstname, :lastname)
  end

end