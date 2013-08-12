class Admin::Layouts::ScriptsController < AdminController

  def create
    @layout = Layout.find(params[:layout_id])
    @layout.scripts << Script.find(params[:script_id])
    if @layout.save
      redirect_to admin_layout_path(@layout)
    else
      render text: "#{@layout.errors}"
    end

  end

  def destroy
    @layout = Layout.find(params[:layout_id])
    @script = Script.find(params[:id])
    @layout.scripts.delete(@script)
    redirect_to admin_layout_path(@layout)
  end

end
