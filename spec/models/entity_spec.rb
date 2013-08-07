require 'spec_helper'

describe Entity do
  
  before(:each) do
    @props = [FactoryGirl.build(:property, name: 'first', kind: :string, req: true),
              FactoryGirl.build(:property, name: 'second', kind: :string)]
    @type = FactoryGirl.create(:type, properties: @props)
    @entity = FactoryGirl.build(:entity, type: @type,
                                         values: { first: 'firstVal', 
                                                   second: 'secondVal'})
  end

  it 'should have a valid factory' do
    @entity.should be_valid
  end

  it 'must have a type' do
    @entity.type = nil
    @entity.should_not be_valid
  end

  it 'must have values for required properties' do
    @entity.values = { first: nil, second: 'not-nil' }
    @entity.should_not be_valid
    @entity.values = { first: '', second: 'not-nil' }
    @entity.should_not be_valid
  end

  it 'accepts symbols for value keys' do
    @entity.values = { :first => 'value' }
    @entity.save
    @entity.values[:first].should be_nil
    @entity.values['first'].should eq 'value'
  end

end
