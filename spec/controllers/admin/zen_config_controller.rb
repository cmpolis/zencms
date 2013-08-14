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
