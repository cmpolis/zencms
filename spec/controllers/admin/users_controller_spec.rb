require 'spec_helper'

describe Admin::UsersController do
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

    it "populates an array of users" do
      FactoryGirl.create(:user, email: 'another1@test.com')
      FactoryGirl.create(:user, email: 'another2@test.com')
      get :index
      assigns(:users).should have(3).items
    end

  end

  describe "GET #show" do
    it "shows a speciic user" do
      @testUser = FactoryGirl.create(:user, email: 'another2@test.com')
      get :show, id: @testUser

      response.should render_template :show
      assigns(:user).should eq(@testUser)
    end
  end

  describe "PUT #update" do
    it "can update user admin level" do
      @testUser = FactoryGirl.create(:user, email: 'another2@test.com')
      put :update, id: @testUser, user: { admin_level: 5 }

      @testUser.reload.admin_level.should eql(5)
    end
  end

end
