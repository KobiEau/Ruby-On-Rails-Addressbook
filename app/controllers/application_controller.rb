class ApplicationController < ActionController::Base
  #before_action :require_authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  #allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  # stale_when_importmap_changes

  before_action :authenticate_user!
  # redirect to login page if no one is signed in
  # Runs before every action in every controller

  helper_method :admin?
  #Make admin? available in views as well as controllers

  private

  def admin?
    user_signed_in? && current_user.admin?
    # user_signed_in? — Devise helper, true if logged in
    # current_user — Devise helper, returns the logged in User object
    # .admin? — our method on User model, checks role_code == "adm"
  end

  def require_admin!
    unless admin?
      flash[:alert] = "You are not authorized to access this area."
      redirect_to root_path
    end
  end
end
