require 'spec_helper'

describe Admin::DashboardController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET #index" do
    it "is accessible to admins" do
      @user.update_attributes(admin_level: 1)
      get :index
      response.should render_template :index
    end

    it "is not accessible to non-admins" do
      @user.update_attributes(admin_level: 0)
      get :index
      response.should be_redirect
    end

    it "is not accessible to guests" do
      sign_out @user
      get :index
      response.should be_redirect
    end
  end

end
