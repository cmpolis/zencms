class Admin::StylesController < AdminController

  def index
    @styles = Style.all.to_a
  end
  
  def show
    @style = Style.find(params[:id])
  end

  def create
    @style = Style.new(params[:style].permit(:name, :content))
    if @style.save
      redirect_to admin_style_path(@style)
    else
      render text: "#{@style.errors}"
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
    @style = Style.find(params[:id])
    @style.destroy unless @style.nil?
    redirect_to admin_styles_path
  end

end
