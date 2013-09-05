class Admin::StaticsController < AdminController

  def index
    @statics = Static.all.to_a
  end
  
  def show
    @static = Static.find(params[:id])
  end

  def create
    @static = Static.new(params[:static].permit(:name, :path, :layout_id))
    if @static.save
      flash[:success] = "Static successfully created."
      redirect_to admin_static_path(@static)
    else
      flash[:alert] = "Unable to create static: #{@static.errors.full_messages}"
      redirect_to admin_statics_path
    end
  end

  def update
    @static = Static.find(params[:id])
    if @static.update_attributes(params[:static].permit(:name, :path, :layout_id))
      flash[:success] = "Static successfully updated."
    else
      flash[:alert] = "Unable to create layout: #{@layout.errors.full_messages}"
    end
    redirect_to admin_static_path(@static)
  end
end
