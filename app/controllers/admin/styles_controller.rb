class Admin::StylesController < AdminController

  def index
    @styles = Style.all.to_a
  end
  
  def show
    @style = Style.find(params[:id])
  end
end
