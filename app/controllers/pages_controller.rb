class PagesController < ApplicationController
  #skip_before_action :require_authentication
  skip_before_action :authenticate_user!, only: [:home]
  #skip Devise login requirement for the home page only
  #Every other page requires login
  
  def home
    #redirect_to contacts_path if authenticated?
    redirect_to contacts_path if user_signed_in?
    # user_signed_in?- Devise helper
    # if already logged in, skip homepage and go straight to contacts
  end
end
