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

  it 'should have a list of possible values if it is an enum' do
    FactoryGirl.build(:property, kind: :enum, possible: nil).should_not be_valid
    FactoryGirl.build(:property, kind: :enum, possible: []).should_not be_valid
    # throws error -> FactoryGirl.build(:property, kind: :enum, possible: 42).should_not be_valid
    FactoryGirl.build(:property, kind: :enum, possible: %w(a b c)).should be_valid
  end

  context 'using entity values' do
    before(:each) do
      @props = [FactoryGirl.build(:property, name: 'enum',
                                             kind: :enum, 
                                             possible: %w(a b c)),
                FactoryGirl.build(:property, name: 'int',
                                             kind: :integer),
                FactoryGirl.build(:property, name: 'array',
                                             kind: :array),
                FactoryGirl.build(:property, name: 'float',
                                             kind: :float)]
      @type = FactoryGirl.create(:type, properties: @props)
      @entity = FactoryGirl.build(:entity, type: @type)
    end

    it 'should validate integer types' do
      @entity.values = { int: 'banana' }
      @entity.should_not be_valid

      @entity.values = { int: 32 }
      @entity.should be_valid
    end
  
    it 'should validate float types' do
      @entity.values = { float: 'banana' }
      @entity.should_not be_valid

      @entity.values = { float: 3.2 }
      @entity.should be_valid
    end

    it 'should validate array types' do
      @entity.values = { array: 'banana' }
      @entity.should_not be_valid

      @entity.values = { array: %w(one two three) }
      @entity.should be_valid
    end

    it 'should validate enum value is in possible' do
      @entity.values = { enum: 'banana' }
      @entity.should_not be_valid

      @entity.values = { enum: 'a' }
      @entity.should be_valid
    end
  end

end
