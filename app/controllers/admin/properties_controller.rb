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
    @prop = @type.properties.build(params[:property].permit(:name, :kind))
    if @prop.save
      redirect_to admin_type_path(@type)
    else
      render text: "#{@prop.errors}"
    end
  end
end
