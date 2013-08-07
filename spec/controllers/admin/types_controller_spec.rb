require 'spec_helper'

describe Admin::TypesController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user

    3.times do
      @properties = [FactoryGirl.build(:property),
                   FactoryGirl.build(:property)]
      @type = FactoryGirl.create(:type, properties: @properties)
    end
  end

  describe "GET #index" do
    it "populates an array of types" do
      get :index
      assigns(:types).should have(3).items
    end
  end

  describe "GET #show" do
    it "shows a speciic type" do
      get :show, id: @type

      response.should render_template :show
      assigns(:type).should eq(@type)
    end
  end

end
