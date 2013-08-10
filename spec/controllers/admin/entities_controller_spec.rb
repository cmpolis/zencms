require 'spec_helper'

describe Admin::EntitiesController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user

    @properties = [FactoryGirl.build(:property, name: 'first'),
                   FactoryGirl.build(:property, name: 'second')]
    @type = FactoryGirl.create(:type, properties: @properties)

    3.times do |ndx|
      @entity = FactoryGirl.create(:entity, type: @type) 
    end
  end

  describe "GET #index" do
    it "populates an array of entities" do
      get :index, type_name: @type.name

      response.should render_template :index
      assigns(:entities).should have(3).items
    end
  end

  describe "GET #show" do
    it "shows a speciic entity" do
      get :show, type_name: @type.name, id: @entity

      response.should render_template :show
      assigns(:entity).should eq(@entity)
    end
  end

end
