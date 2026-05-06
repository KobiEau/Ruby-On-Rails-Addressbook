class Users::RegistrationController < Devise::RegistrationsController
  #handling  password change separately other fields
  def update
    if params[:user][:current_password].present?
      super
    else
      @user = current_user
      if @user.update_without_password(update_params)
        redirect_to edit_user_registration_path, notice: "Account Profile updated."
      else
        render :edit, status: :unporcessable_entity
      end
    end
  end 

  private

  def update_params
    params.require(:user).permit(:email,:firstname,:lastname)
  end

  def sign_up_params
    params.require(:user).permit.(:email, :password, :password_confirmation,:firstname,:lastname)
  end

  def after_sign_up_path_for(resource)
    #where to go after signing up - contacts index
    contacts_path
  end

  def after_update_path_for(resource)
      #stay on edit page after updating profile
  end
end