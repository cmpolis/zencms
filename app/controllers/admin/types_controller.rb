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
      redirect_to admin_types_path
    else
      render text: 'Could not destroy type'
    end
  end

  def create
    @type = Type.new(params[:type].permit(:name))
    if @type.save
      redirect_to admin_type_path(@type)
    else
      render text: "#{@type.errors}"
    end
  end

  def update
    @type = Type.find(params[:id])
    @type.update_attributes(params[:type].permit(:primary_property))
    if params[:type][:layout]
      @layout = params[:type][:layout].blank? ? nil : Layout.find(params[:type][:layout])
      @type.layout = @layout
      @type.save
    end
    redirect_to admin_type_path(@type)
  end
end
