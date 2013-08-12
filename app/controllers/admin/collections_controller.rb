class Admin::CollectionsController < AdminController

  def index
    @collections = Collection.all.to_a
  end
  
  def show
    @collection = Collection.find(params[:id])
  end

  def create
    @collection = Collection.new(params[:collection].permit(:name))
    if @collection.save
      redirect_to admin_collection_path(@collection)
    else
      render text: "#{@collection.errors}"
    end
  end
end
