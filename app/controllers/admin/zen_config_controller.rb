class Admin::ZenConfigController < AdminController
  
  def show
    @config = ZenConfig.instance
  end

  def update
    @config = ZenConfig.instance
    if @config.update_attributes(params[:zen_config].permit([:ga_tracking_id, :ga_enabled, :base_url, :admin_email, :twitter_handle]))
    else
    end
    render :show
  end

end
