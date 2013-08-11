class Admin::ScriptsController < AdminController

  def index
    @scripts = Script.all.to_a
  end
  
  def show
    @script = Script.find(params[:id])
  end

  def create
    if params[:layout_id].blank?
      @script = Script.new(params[:script].permit(:name, :content))
      if @script.save
        redirect_to admin_script_path(@script)
      else
        render text: "#{@script.errors}"
      end

    else
      @layout = Layout.find(params[:layout_id])
      @layout.scripts << Script.find(params[:script_id])
      if @layout.save
        redirect_to admin_layout_path(@layout)
      else
        render text: "#{@layout.errors}"
      end

    end
  end

  def update
    @script = Script.find(params[:id])
    if @script.update_attributes(params[:script].permit(:name, :content))
 
    else

    end
    redirect_to admin_script_path(@script)
  end

  def destroy
    @layout = Layout.find(params[:layout_id])
    @script = Script.find(params[:id])
    @layout.scripts.delete(@script)
    redirect_to admin_layout_path(@layout)
  end

end
