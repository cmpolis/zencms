class Admin::LayoutsController < AdminController

  def index
    @layoutss = Layout.all.to_a
  end
  
  def show
    @layouts = Layout.find(params[:id])
  end
end
