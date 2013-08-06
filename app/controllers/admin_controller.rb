class AdminController < ApplicationController
  before_filter :verify_admin

  def verify_admin
    redirect_to root_path unless current_user and current_user.is_admin?
  end

end
