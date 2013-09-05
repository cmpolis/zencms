class Admin::PropertiesController < AdminController
  
  def destroy
    @type = Type.find(params[:type_id])
    @prop = @type.properties.find(params[:id])
    if @prop.nil?
      render text: 'Could not find property'
    else
      @prop.destroy
      redirect_to admin_type_path(@type)
    end
  end

  def create
    @type = Type.find(params[:type_id])
    prop = params[:property]
    prop[:possible] = prop[:possible].split(/\s*\,\s*/) if prop[:possible]

    @prop = @type.properties.build(prop.permit(:name, :kind, :possible => []))
    if @prop.save
      redirect_to admin_type_path(@type)
    else
      render text: "#{@prop.errors.messages}"
    end
  end

  def update
    @type = Type.find(params[:type_id])
    @prop = @type.properties.find(params[:id])
    if @prop.update_attributes(params[:property].permit(:req))
      redirect_to admin_type_path(@type)
    else
      render text: "#{@prop.errors}"
    end
  end

end
