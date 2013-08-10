class Admin::ScriptsController < AdminController

  def index
    @scripts = Script.all.to_a
  end
  
  def show
    @script = Script.find(params[:id])
  end

  def create
    @script = Script.new(params[:script].permit(:name, :content))
    if @script.save
      redirect_to admin_script_path(@script)
    else
      render text: "#{@script.errors}"
    end
  end

  def update
    @script = Script.find(params[:id])
    if @script.update_attributes(params[:script].permit(:name, :content))
 
    else

    end
    redirect_to admin_script_path(@script)
  end
end
