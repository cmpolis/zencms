require 'spec_helper'

describe Admin::StaticsController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    
    @layout = FactoryGirl.create(:layout)
    3.times do
      @static = FactoryGirl.create(:static, layout: @layout)
    end
  end

  describe "GET #index" do
    it "populates an array of statics" do
      get :index
      assigns(:statics).should have(3).items
    end
  end

  describe "GET #show" do
    it "shows a speciic static" do
      get :show, id: @static

      response.should render_template :show
      assigns(:static).should eq(@static)
    end
  end

  describe "PUT #update" do
    it "updates attributes" do
      @newLayout = FactoryGirl.create(:layout)
      put :update, id: @static, static: { path: 'newPath',
                                          layout_id: @newLayout.id }
      @static.reload.path.should eql 'newPath'
      @static.layout.name.should eql @newLayout.name
    end
  end

  describe "POST #create" do
    it "creates a static page" do
      expect {
        put :create, static: { path: 'test',
                               name: 'thisisapath',
                               layout_id: @layout.id }
      }.to change(Static, :count).by(1)
    end
  end

end
