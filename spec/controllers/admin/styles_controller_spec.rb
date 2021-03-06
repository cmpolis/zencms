require 'spec_helper'

describe Admin::StylesController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    
    3.times do
      @style = FactoryGirl.create(:style)
    end
  end

  describe "GET #index" do
    it "populates an array of styles" do
      get :index
      assigns(:styles).should have(3).items
    end
  end

  describe "GET #show" do
    it "shows a speciic style" do
      get :show, id: @style

      response.should render_template :show
      assigns(:style).should eq(@style)
    end
  end

  describe "PUT #update" do
    it "can update attributes" do
      put :update, id: @style, style: { name: 'new_name',
                                         content: 'body { color: blue; }' }
      @style.reload.name.should eql 'new_name'
      @style.content.should include 'color: blue;'
    end
    it "can use reference url" do
      put :update, id: @style, style: { name: 'new_name',
                                        content: nil, 
                                        reference_url: 'http://google.com/test.js' }
      @style.reload.reference_url.should include 'test.js'
    end
  end

end
