class Admin::BaseController < ApplicationController
  before_action :require_admin!
  layout "admin"
  #controllers inheriting from this are admin-only
  #guard is placed here instead of repeating in every other class
end