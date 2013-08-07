class Admin::CollectionsController < AdminController

  def index
    @collections = Collection.all.to_a
  end
  
  def show
    @collection = Collection.find(params[:id])
  end
end
