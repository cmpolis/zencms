class AdminController < ApplicationController
  before_filter :verify_admin
  before_action :load_types

  def verify_admin
    redirect_to root_path unless current_user and current_user.is_admin?
  end

  def load_types
    @types = Type.all.to_a
  end

end
