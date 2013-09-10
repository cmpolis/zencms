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

  describe "PUT #update" do
    it "can update attributes" do
      put :update, id: @collection, collection: { name: 'namechange',
                                                  entity_ids: [] }
      @collection.reload.name.should eql 'namechange'
      @collection.entities.should be_empty
    end

    it "can reorder entities" do
      entities = Entity.all.to_a
      new_ids = entities.reverse.map { |e| e.id.to_s }
      @collection.update_attributes(entities: entities).should be_true
      put :update, id: @collection, collection: { name: 'namechange',
                                                  entity_ids: new_ids }
      @collection.reload.ordered_entities.first.should eql(entities.last)
    end
  end

end
