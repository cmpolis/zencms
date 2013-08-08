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

end
