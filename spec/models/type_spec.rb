require 'spec_helper'

describe Type do

  it 'should have a valid factory' do
    FactoryGirl.create(:type).should be_valid
  end

  it 'must have a unique name' do
    @type = FactoryGirl.create(:type)
    @type.should be_valid
    FactoryGirl.build(:type, name: @type.name).should_not be_valid
    FactoryGirl.build(:type, name: nil).should_not be_valid
  end

  it 'can embed many properties' do
    @props = [FactoryGirl.build(:property), 
              FactoryGirl.build(:property)]
    @type = FactoryGirl.create(:type, properties: @props)

    @type.should be_valid
    @type.properties.should have(2).items
  end

  it 'can have entities' do
    @props = [FactoryGirl.build(:property),
              FactoryGirl.build(:property)]
    @type = FactoryGirl.create(:type, properties: @props)
    @entity = Entity.create(type: @type, values: { @props[0].name => 'a',
                                                   @props[1].name => 'b'})
    @type.entities.should have(1).items
  end

  it 'must have uniquely named properties' do
    @props = [FactoryGirl.build(:property, name: 'same'), 
              FactoryGirl.build(:property, name: 'same')]
    @type = FactoryGirl.build(:type, properties: @props)
    @type.should_not be_valid
  end

  it 'must have a primary property that is a property' do
    @props = [FactoryGirl.build(:property), 
              FactoryGirl.build(:property)]
    @type = FactoryGirl.build(:type, properties: @props)
    @type.primary_property = 'ZZZ IJDFI NSF INVALID'
    @type.should_not be_valid
    @type.primary_property = @props[0].name
    @type.should be_valid
  end

  it 'must have valid kinds of properties' do
    FactoryGirl.build(:property, kind: :INVALIDKIND).should_not be_valid
    FactoryGirl.build(:property, kind: :string).should be_valid
  end

  it 'can have a layout' do
    @layout = FactoryGirl.create(:layout)
    @type = FactoryGirl.create(:type, layout: @layout)
    @type.should be_valid
    @type.layout.should_not be_nil
  end

  it 'should have a normalized name' do
    @type = FactoryGirl.create(:type, name: 'Dogs')
    @type.name.should eql 'dog'
    @type = FactoryGirl.create(:type, name: 'bOoK')
    @type.name.should eql 'book'
  end

end
