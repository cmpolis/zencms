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
      flash[:success] = "Collection successfully created."
      redirect_to admin_collection_path(@collection)
    else
      flash[:alert] = "Unable to create collection: #{@collection.errors.full_messages}"
      redirect_to admin_collections_path
    end
  end

  def update
    @collection = Collection.find(params[:id])
    if @collection.update_attributes(params[:collection].permit(:name, :entity_ids => []))
      flash[:success] = "Collection successfully updated."
    else
      flash[:alert] = "Unable to update collection: #{@collection.errors.full_messages}"
    end
    redirect_to admin_collection_path(@collection)
  end
end
