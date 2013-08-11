class StylesController < ApplicationController

  def show
    @style = Style.where(name: params[:style_name]).first
    if @style
      render text: @style.content
    else
      render text: 'ERROR: stylesheet not found'
    end
  end

end
