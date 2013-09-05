class Admin::StylesController < AdminController

  def index
    @styles = Style.all.to_a
  end
  
  def show
    @style = Style.find(params[:id])
  end

  def create
    @style = Style.new(params[:style].permit(:name, :content, :reference_url))
    if @style.save
      flash[:success] = "Style successfully created."
      redirect_to admin_style_path(@style)
    else
      flash[:alert] = "Unable to create style: #{@style.errors.full_messages}"
      redirect_to admin_styles_path
    end
  end

  def update
    @style = Style.find(params[:id])
    if @style.update_attributes(params[:style].permit(:name, :content, :reference_url))
      flash[:success] = "Style successfully updated."
    else
      flash[:alert] = "Unable to create style: #{@style.errors.full_messages}"
    end
    redirect_to admin_style_path(@style)
  end

  def destroy
    @style = Style.find(params[:id])
    @style.destroy unless @style.nil?
    flash[:success] = "Style successfully destroyed."
    redirect_to admin_styles_path
  end

end
