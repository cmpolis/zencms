require 'spec_helper'

describe Admin::LayoutsController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    
    @type = FactoryGirl.create(:type)
    3.times do
      @layout = FactoryGirl.create(:layout)
    end
  end

  describe "GET #index" do
    it "populates an array of layouts" do
      get :index
      assigns(:layouts).should have(3).items
    end
  end

  describe "GET #show" do
    it "shows a speciic layout" do
      get :show, id: @layout

      response.should render_template :show
      assigns(:layout).should eq(@layout)
    end
  end

  describe "PUT #update" do
    it "can update attributes" do
      @parent = Layout.first
      put :update, id: @layout, layout: { content: 'content change',
                                          parent_id: @parent }
      @layout.reload.content.should eql 'content change'
      @layout.parent.name.should eql @parent.name
    end
  end

end
