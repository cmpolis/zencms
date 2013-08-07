require 'spec_helper'

describe Admin::ConfigsController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET #show" do
    it "shows config options"
  end

end
