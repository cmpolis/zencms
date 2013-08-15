require 'spec_helper'

describe Admin::ZenConfigController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET #show" do
    it "loads config options" do
      assigns(:config).should_not be_nil
    end
  end

  describe "PUT #update" do
    it "updates the config singleton" do
      put :update, zen_config: { ga_enabled: true,
                                 base_url: 'newurl',
                                 twitter_handle: 'newtwitter' }
       ZenConfig.instance.ga_enabled.should be_true 
       ZenConfig.instance.base_url.should eql 'newurl' 
       ZenConfig.instance.twitter_handle.should eql 'newtwitter' 
    end
  end

end
