require 'spec_helper'

describe Admin::TypesController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET #index" do
    it "populates an array of types"
  end

  describe "GET #show" do
    it "shows a speciic type"
  end

end
