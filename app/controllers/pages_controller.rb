class PagesController < ApplicationController

  def show
    @entity = Entity.with_path params[:path]
    @static = Static.with_path params[:path]

    # check static pages
    if @static
      render text: @static.layout.parse

    # check default paths
    elsif @entity
      @layout = @entity.type.layout
      render text: @layout.parse_with_entity(@entity)
      
    #check alternate paths
    elsif false

    elsif params[:path] == ''
      render :welcome

    else

      render text: "Entity not found with path: #{params[:path]}"
    end
  end

end
