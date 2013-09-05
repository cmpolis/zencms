class Admin::LayoutsController < AdminController

  def index
    @layouts = Layout.all.to_a
  end
  
  def show
    @layout = Layout.find(params[:id])
  end

  def create
    @layout = Layout.new(params[:layout].permit(:name, :content))
    if @layout.save
      flash[:success] = "Layout successfully created."
      redirect_to admin_layout_path(@layout)
    else
      flash[:alert] = "Unable to create layout: #{@layout.errors.full_messages}"
      redirect_to admin_layouts_path
    end
  end

  def update
    @layout = Layout.find(params[:id])
    @layout.scripts << Script.find(params[:new_script]) unless params[:new_script].blank?
    if @layout.update_attributes(params[:layout].permit(:content, :parent_id, :script_ids))
      flash[:success] = "Layout succesfully updated."
 
    else
      flash[:alert] = "Unable to update layout: #{@layout.errors.full_messages}"
    end
    redirect_to admin_layout_path(@layout)
  end
end
