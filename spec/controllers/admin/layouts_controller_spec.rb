require 'spec_helper'

describe Admin::LayoutsController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET #index" do
    it "populates an array of layouts"
  end

  describe "GET #show" do
    it "shows a speciic layout"
  end

end
