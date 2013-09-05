class Admin::TypesController < AdminController

  def index
    @types = Type.all.to_a
  end
  
  def show
    @type = Type.find(params[:id])
  end

  def destroy
    @type = Type.find(params[:type_id])
    if @type.destroy
      flash[:success] = "Type successfully destroyed."
    else
      flash[:alert] = "Unable to destroy type."
    end
    redirect_to admin_types_path
  end

  def create
    @type = Type.new(params[:type].permit(:name))
    if @type.save
      flash[:success] = "Type successfully created."
      redirect_to admin_type_path(@type)
    else
      flash[:alert] = "Unable to create type: #{@type.errors.full_messages}"
      redirect_to admin_types_path
    end
  end

  def update
    @type = Type.find(params[:id])
    if @type.update_attributes(params[:type].permit(:primary_property, :layout_id))
      flash[:success] = "Type successfully updated."
    else
      flash[:alert] = "Unable to update type: #{@type.errors.full_messages}" 
    end
    redirect_to admin_type_path(@type)
  end
end
