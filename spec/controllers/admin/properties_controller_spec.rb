require 'spec_helper'

describe Admin::PropertiesController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user

    3.times do
      @properties = [FactoryGirl.build(:property, req: false),
                     FactoryGirl.build(:property)]
      @type = FactoryGirl.create(:type, properties: @properties)
    end
    @prop = @properties.first
  end

  describe "POST #create" do
    it "creates a new property object" do
      post :create, type_id: @type,
                    property: { name: 'testprop',
                                kind: 'string' }
      @type.reload.properties.where(name: 'testprop').first.should_not be_nil
    end

    it "accepts comma seperated values for enum type" do
      post :create, type_id: @type,
                    property: { name: 'enumprop',
                                kind: 'string',
                                possible: 'one, two, three and four' }
      pp @type.reload.properties
      @new = @type.reload.properties.where(name: 'enumprop').first
      @new.possible.should have(3).items
      @new.possible.should include('two')
    end
  end

  describe "PUT #update" do
    it "can update attributes" do
      put :update, type_id: @type, id: @prop, property: { req: true }
      @prop.reload.req.should be_true
      put :update, type_id: @type, id: @prop, property: { req: false }
      @prop.reload.req.should be_false
    end
  end

end
