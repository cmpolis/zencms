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
    @properties = [FactoryGirl.build(:property), 
                   FactoryGirl.build(:property)]
    @type = FactoryGirl.create(:type, properties: @properties)

    @type.should be_valid
    @type.properties.should have(2).items
  end

  it 'must have uniquely named properties' do
    @properties = [FactoryGirl.build(:property, name: 'same'), 
                   FactoryGirl.build(:property, name: 'same')]
    @type = FactoryGirl.build(:type, properties: @properties)
    @type.should_not be_valid
  end

  it 'must have valid kinds of properties' do
    FactoryGirl.build(:property, kind: :INVALIDKIND).should_not be_valid
    FactoryGirl.build(:property, kind: :string).should be_valid
  end

end
