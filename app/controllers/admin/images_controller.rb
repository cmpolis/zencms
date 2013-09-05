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
      flash[:success] = "Image successfully created."
      redirect_to admin_image_path(@image)
    else
      flash[:alert] = "Unable to create image: #{@image.errors.full_messages}"
      redirect_to admin_images_path
    end 
  end

  def update
  end

  def destroy
  end

end
