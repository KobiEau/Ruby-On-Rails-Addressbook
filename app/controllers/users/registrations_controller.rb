class Users::RegistrationsController < Devise::RegistrationsController
  #handling  password change separately other fields
  
  def after_sign_up_path_for(resource)
    #where to go after signing up - contacts index
    contacts_path
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :firstname, :lastname)
  end

end