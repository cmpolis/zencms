class ScriptsController < ApplicationController

  def show
    @script = Script.where(name: params[:script_name]).first
    if @script
      render text: @script.content
    else
      render text: 'ERROR: script not found'
    end
  end

end
