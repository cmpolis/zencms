class Admin::ScriptsController < AdminController

  def index
    @scripts = Script.all.to_a
  end
  
  def show
    @script = Script.find(params[:id])
  end

  def create
    @script = Script.new(params[:script].permit(:name, :content, :reference_url))
    if @script.save
      flash[:success] = "Script successfully created."
      redirect_to admin_script_path(@script)
    else
      flash[:alert] = "Unable to create script: #{@script.errors.full_messages}"
      redirect_to admin_scripts_path
    end
  end

  def update
    @script = Script.find(params[:id])
    if @script.update_attributes(params[:script].permit(:name, :content, :reference_url))
      flash[:success] = "Script successfully updated." 
    else
      flash[:alert] = "Unable to update script: #{@script.errors.full_messages}"
    end
    redirect_to admin_script_path(@script)
  end

  def destroy
    @script = Script.find(params[:id])
    @script.destroy unless @script.nil?
    flash[:success] = "Script successfully destroyed."
    redirect_to admin_scripts_path
  end

end
