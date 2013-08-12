require 'spec_helper'

describe Admin::CollectionsController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user

    @type = FactoryGirl.create(:type, properties: [FactoryGirl.build(:property)])
    3.times { @entity = FactoryGirl.create(:entity, type: @type) }
    3.times { @collection = FactoryGirl.create(:collection) }
  end

  describe "GET #index" do
    it "populates an array of collections" do
      get :index
      assigns(:collections).should have(3).items
    end  
  end

  describe "GET #show" do
    it "shows a speciic collection" do
      get :show, id: @collection
      
      response.should render_template :show
      assigns(:collection).should eq(@collection)
    end
  end

  describe "POST #create" do
    it "creates a new collection" do
      expect {
        post :create, collection: { name: 'newcollection' }
      }.to change(Collection, :count).by(1)
    end
  end

end
