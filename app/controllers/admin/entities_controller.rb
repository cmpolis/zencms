class Admin::EntitiesController < AdminController
  
  def index
    @type = Type.where(name: params[:type_name]).first
  end

  def show
    @type = Type.where(name: params[:type_name]).first
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
end
