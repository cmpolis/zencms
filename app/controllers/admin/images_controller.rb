class Admin::ImagesController < AdminController

  def index
    @images = Image.all.to_a
  end
  
  def show
    @image = Image.find(params[:id])
  end

  def create
  end

  def update
  end

  def destroy
  end

end
