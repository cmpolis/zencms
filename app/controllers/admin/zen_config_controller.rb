class Admin::ZenConfigController < AdminController
  
  def show
    @config = ZenConfig.instance
  end

  def update
    @config = ZenConfig.instance
    if @config.update_attributes(params[:zen_config].permit([:ga_tracking_id]))
    else
    end
    render :show
  end

end
