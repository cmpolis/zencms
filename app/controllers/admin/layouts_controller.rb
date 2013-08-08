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
      redirect_to admin_layout_path(@layout)
    else
      render text: "#{@layout.errors}"
    end
  end

  def update
    @layout = Layout.find(params[:id])
    if @layout.update_attributes(params[:layout].permit(:content, :parent_id))
 
    else

    end
    redirect_to admin_layout_path(@layout)
  end
end
