class Admin::StylesController < AdminController

  def index
    @styles = Style.all.to_a
  end
  
  def show
    @style = Style.find(params[:id])
  end

  def create
    if params[:layout_id].blank?
      @style = Style.new(params[:style].permit(:name, :content))
      if @style.save
        redirect_to admin_style_path(@style)
      else
        render text: "#{@style.errors}"
      end

    else
      @layout = Layout.find(params[:layout_id])
      @layout.styles << Style.find(params[:style_id])
      if @layout.save
        redirect_to admin_layout_path(@layout)
      else
        render text: "#{@layout.errors}"
      end
    end
  end

  def update
    @style = Style.find(params[:id])
    if @style.update_attributes(params[:style].permit(:name, :content))
 
    else

    end
    redirect_to admin_style_path(@style)
  end

  def destroy
    @layout = Layout.find(params[:layout_id])
    @style = Style.find(params[:id])
    @layout.styles.delete(@style)
    redirect_to admin_layout_path(@layout)
  end

end
