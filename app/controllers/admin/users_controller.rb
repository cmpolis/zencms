class Admin::UsersController < AdminController

  def index
    @users = User.all.to_a
  end
  
  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user and @user.update_attributes(params[:user].permit(:admin_level))
      flash[:success] = "User successfully updated."
    else
      flash[:alert] = "Unable to update user: #{@user.errors.full_messages}"
    end
    redirect_to admin_users_path 
  end
end
