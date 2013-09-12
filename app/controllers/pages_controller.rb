class PagesController < ApplicationController

  def show
    @entity = Entity.with_path params[:path]
    @static = Static.with_path params[:path]
    html = ""
    is_admin = current_user and current_user.is_admin?

    # check static pages
    if @static
      @layout = @static.layout
      html = @layout.parse(is_admin)

    # check default paths
    elsif @entity
      @layout = @entity.type.layout
      html = @layout.parse_with_entity(@entity, nil, is_admin)
      
    end
    if !html.blank? and is_admin
      html = Layout.prepend_to_body(html, render_to_string('admin/_topbar', layout: false))
      html = Layout.append_to_head(html, render_to_string('admin/_admin_head', layout: false))
    end

    if html.blank? and params[:path].blank?
      render :welcome
    elsif html.blank?
      render text: "Entity not found with path: #{params[:path]}"
    else
      html = Layout.append_to_head(html, render_to_string('pages/_base', layout: false))
      # html = Layout.add_admin_attrs(html) if is_admin
      render text: html
    end
  end

end
