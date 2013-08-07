class Admin::TypesController < AdminController

  def index
    @types = Type.all.to_a
  end
  
  def show
    @type = Type.find(params[:id])
  end
end
