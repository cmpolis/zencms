require 'spec_helper'

describe Admin::Layouts::StylesController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    
    3.times do
      @style = FactoryGirl.create(:style)
    end
  end

  describe "POST #create" do
    it "can link styles to layouts" do
      @layout = FactoryGirl.create(:layout, styles: [])
      post :create, layout_id: @layout.id, style_id: @style
      @layout.reload.styles.should have(1).items
    end
  end

  describe "DELETE #destroy" do
    it "can unlink styles from layouts" do
      @layout = FactoryGirl.create(:layout, styles: Style.all.to_a)
      delete :destroy, layout_id: @layout.id, id: @style
      @layout.reload.styles.should have(Style.count - 1).items
    end
  end

end
