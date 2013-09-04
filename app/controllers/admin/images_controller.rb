class Admin::ImagesController < AdminController

  def index
    @images = Image.all.to_a
  end
  
  def show
    @image = Image.find(params[:id])
  end

  def create
    @image = Image.new(params[:image].permit(:name, :file))
    if @image.save
      redirect_to admin_image_path(@image)
    else
      render text: "#{@image.errors}"
    end 
  end

  def update
  end

  def destroy
  end

end
