class Admin::EntitiesController < AdminController
  
  def index
    @type = Type.where(name: params[:type_name]).first
    @entities = @type.entities
  end

  def show
    @type = Type.where(name: params[:type_name]).first
    @entity = Entity.find(params[:id])
  end

  def destroy
    @type = Type.find(params[:type_id])
    @entity = Entity.find(params[:id])
    if @type.nil? or @entity.nil?
      render text: 'Could not delete entity'
    else
      @entity.destroy
      redirect_to admin_entity_list_path(@type.name)
    end
  end

  def create
    @type = Type.find(params[:type_id])
    @entity = @type.entities.build(
               params[:entity].permit(:values => params[:entity][:values].keys))
    if @entity.save
    
    else

    end
    redirect_to admin_entity_list_path(@type.name)
  end

  def update
    @type = Type.where(name: params[:type_name]).first
    @entity = Entity.find(params[:id])
    @entity.update_attributes(
        params[:entity].permit(:values => params[:entity][:values].keys))
     @entity.update_attributes(
        params[:entity].permit(:default_path))
    # TODO: rewrite two statements above this into one...
    redirect_to admin_entity_path(@type.name, @entity.id)
  end
end
