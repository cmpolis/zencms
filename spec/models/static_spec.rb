require 'spec_helper'

describe Static do
  before(:each) do
    @layout = FactoryGirl.create(:layout)
    @static = FactoryGirl.create(:static, layout: @layout)
  end

  it 'should have a valid factory' do
    @static.should be_valid
  end

  it 'must have a unique name' do
    FactoryGirl.build(:static, name: @static.name).should_not be_valid
  end

  it 'must belong to a layout' do
    @static.layout.statics.should include @static
    @static.layout = nil
    @static.should_not be_valid
  end

  it 'must have a path' do
    @static.path = nil
    @static.should_not be_valid
  end

end
