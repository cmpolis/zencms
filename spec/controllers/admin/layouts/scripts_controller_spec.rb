require 'spec_helper'

describe Admin::Layouts::ScriptsController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    
    3.times do
      @script = FactoryGirl.create(:script)
    end
  end

  describe "POST #create" do
    it "can link scripts to layouts" do
      @layout = FactoryGirl.create(:layout, scripts: [])
      post :create, layout_id: @layout.id, script_id: @script
      @layout.reload.scripts.should have(1).items
    end
  end

  describe "DELETE #destroy" do
    it "can unlink scripts from layouts" do
      @layout = FactoryGirl.create(:layout, scripts: Script.all.to_a)
      delete :destroy, layout_id: @layout.id, id: @script
      @layout.reload.scripts.should have(Script.count - 1).items
    end
  end

end
