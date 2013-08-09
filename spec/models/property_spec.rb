require 'spec_helper'

describe Property do

  it 'should have a valid factory' do
    FactoryGirl.build(:property).should be_valid
  end

  it 'should have a lowercase name' do
    @props = [FactoryGirl.build(:property, name: 'fIRst'),
              FactoryGirl.build(:property, name: 'SECOND')]
    @type = FactoryGirl.create(:type, properties: @props)
    @type.properties.collect(&:name).should include 'first'
    @type.properties.collect(&:name).should include 'second'
  end

  it 'should not have spaces in it\'s name' do
    @props = [FactoryGirl.build(:property, name: 'first'),
              FactoryGirl.build(:property, name: 'ToP speed')]
    @type = FactoryGirl.create(:type, properties: @props)
    @type.properties.collect(&:name).should include 'top_speed'
  end

end
