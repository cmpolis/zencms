class Admin::PropertiesController < AdminController
  
  def destroy
    @type = Type.find(params[:type_id])
    @prop = @type.properties.find(params[:id])
    if @prop.nil?
      flash[:alert] = "Unable to destroy property."
    else
      @prop.destroy
      flash[:success] = "Property successfully destroyed."
    end
    redirect_to admin_type_path(@type)
  end

  def create
    @type = Type.find(params[:type_id])
    prop = params[:property]
    prop[:possible] = prop[:possible].split(/\s*\,\s*/) if prop[:possible]

    @prop = @type.properties.build(prop.permit(:name, :kind, :possible => []))
    if @prop.save
      flash[:success] = "Property successfully created."
    else
      flash[:alert] = "Unable to create property: #{@prop.errors.full_messages}"
    end
    redirect_to admin_type_path(@type)
  end

  def update
    @type = Type.find(params[:type_id])
    @prop = @type.properties.find(params[:id])
    if @prop.update_attributes(params[:property].permit(:req))
      flash[:success] = "Property successfully updated."
    else
      flash[:alert] = "Unable to update property: #{@prop.errors.full_messages}"
    end
    redirect_to admin_type_path(@type)
  end

end
