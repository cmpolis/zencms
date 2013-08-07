require 'spec_helper'

describe Admin::CollectionsController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET #index" do
    it "populates an array of collections"
  end

  describe "GET #show" do
    it "shows a speciic collection"
  end

end
