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

  describe "PUT #update" do
    it "can update attributes" do
      put :update, type_id: @type, id: @prop, property: { req: true }
      @prop.reload.req.should be_true
      put :update, type_id: @type, id: @prop, property: { req: false }
      @prop.reload.req.should be_false
    end
  end

end
