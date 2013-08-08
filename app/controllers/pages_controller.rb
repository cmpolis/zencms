class PagesController < ApplicationController

  def show
    # check static pages

    # check default paths
    @entity = Entity.with_path params[:path]
    if @entity
      @layout = @entity.type.layout
      render text: @layout.parse_with_entity(@entity)
      
    else

    #check alternate paths

      render text: "Entity not found with path: #{params[:path]}"
    end
  end

end
