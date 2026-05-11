class Admin::DashboardController < Admin::BaseController
  def index
    @total_users = User.count
    @total_contacts = Contact.count
    @total_admins = User.where(role_code: Role::ADMIN).count
    @recent_users = User.includes(:role,:contacts).order(created_at: :desc).limit(5)
  end
end