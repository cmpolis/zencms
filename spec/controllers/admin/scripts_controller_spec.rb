require 'spec_helper'

describe Admin::ScriptsController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    
    3.times do
      @script = FactoryGirl.create(:script)
    end
  end

  describe "GET #index" do
    it "populates an array of scripts" do
      get :index
      assigns(:scripts).should have(3).items
    end
  end

  describe "GET #show" do
    it "shows a speciic script" do
      get :show, id: @script

      response.should render_template :show
      assigns(:script).should eq(@script)
    end
  end

  describe "PUT #update" do
    it "can update attributes" do
      put :update, id: @script, script: { name: 'new_name',
                                          content: 'alert("b");' }
      @script.reload.name.should eql 'new_name'
      @script.content.should eql 'alert("b");'
    end
    it "can use reference url" do
      put :update, id: @script, script: { name: 'new_name',
                                          content: nil,
                                          reference_url: 'http://google.com/test.css' }
      @script.reload.reference_url.should include 'test.css'
    end
  end

end
