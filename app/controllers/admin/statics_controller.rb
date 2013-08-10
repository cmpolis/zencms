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
      redirect_to admin_static_path(@static)
    else
      render text: "#{@static.errors}"
    end
  end

  def update
    @static = Static.find(params[:id])
    if @static.update_attributes(params[:static].permit(:name, :path, :layout_id))
 
    else

    end
    redirect_to admin_static_path(@static)
  end
end
