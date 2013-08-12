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

  describe "PUT #update" do
    it "should update type attributes" do
      @layout = FactoryGirl.create(:layout)
      put :update, id: @type, type: {
                   primary_property: @properties.last.name,
                   layout_id: @layout.id }

      @type.reload.primary_property.should eql @properties.last.name
      @type.layout.should eq(@layout)
    end
  end

end
