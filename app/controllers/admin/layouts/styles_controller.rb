class Admin::Layouts::StylesController < AdminController

  def create
    @layout = Layout.find(params[:layout_id])
    @layout.styles << Style.find(params[:style_id])
    if @layout.save
      redirect_to admin_layout_path(@layout)
    else
      render text: "#{@layout.errors}"
    end
  end

  def destroy
    @layout = Layout.find(params[:layout_id])
    @style = Style.find(params[:id])
    @layout.styles.delete(@style)
    redirect_to admin_layout_path(@layout)
  end

end
