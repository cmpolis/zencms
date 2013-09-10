require 'spec_helper'

describe Collection do
  
  before(:each) do
    @props = [FactoryGirl.build(:property, name: 'first', kind: :string, req: true),
              FactoryGirl.build(:property, name: 'second', kind: :string)]
    @type = FactoryGirl.create(:type, properties: @props)
    3.times do
      @entity = FactoryGirl.create(:entity, type: @type,
                                            values: { first: 'firstVal', 
                                                      second: 'secondVal'})
    end
    @collection = FactoryGirl.create(:collection, name: 'testcollection', 
                                                  entities: Entity.all)
  end

  it 'should have a valid factory' do
    @collection.should be_valid
  end

  it 'should have a unique name' do
    FactoryGirl.build(:collection, name: nil).should_not be_valid
    FactoryGirl.build(:collection, name: @collection.name).should_not be_valid
  end

  it 'can have entities' do
    @collection.entities = []
    @collection.should be_valid
    @collection.entities << Entity.first
    @collection.should be_valid
  end

  it 'can keep entity order' do
    entities = Entity.all.to_a
    @collection.update_attributes(entities: entities).should be_true
    @collection.ordered_entities.first.should eql(entities.first)
    @collection.update_attributes(entities: entities.reverse).should be_true
    @collection.ordered_entities.first.should eql(entities.last)
  end

end
