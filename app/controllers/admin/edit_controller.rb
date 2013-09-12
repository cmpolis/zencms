class Admin::EditController < AdminController

  def create
    @layout = Layout.find(params[:layout_id])
    puts '*' * 80
    puts @layout
    puts '&' * 80
    puts @layout.merge_edit(params[:content_id], params[:content])
    
    render text: 'success'
  end
  
end
