require 'spec_helper'

describe Layout do

  it 'should have a valid factory' do
    FactoryGirl.create(:layout).should be_valid
  end

  it 'must have a unique name' do
    @layout = FactoryGirl.create(:layout)
    FactoryGirl.build(:layout, name: @layout.name).should_not be_valid
  end

  it 'can have types that use it' do
    @props = [FactoryGirl.build(:property), 
              FactoryGirl.build(:property)]
    @type = FactoryGirl.build(:type, properties: @props)
    @layout = FactoryGirl.create(:layout)
    @type.layout = @layout

    @type.should be_valid
    @layout.should be_valid
    @layout.types.should have(1).items
  end

  it 'must have a name and content' do
    FactoryGirl.build(:layout, content: nil).should_not be_valid
    FactoryGirl.build(:layout, name: nil).should_not be_valid
  end

end
