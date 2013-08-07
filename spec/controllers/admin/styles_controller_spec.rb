require 'spec_helper'

describe Admin::StylesController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET #index" do
    it "populates an array of styles"
  end

  describe "GET #show" do
    it "shows a speciic style"
  end

end
