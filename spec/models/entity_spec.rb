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

  it 'must have a unique default path' do
    @entity.default_path = 'testpath'
    @entity.save
    FactoryGirl.build(:entity, type: @type, 
                               default_path: 'testpath').should_not be_valid 
  end

  it 'generates default paths' do
    @type.update_attributes(primary_property: 'first')
    @entity.values['first'] = 'This IS a test'
    @entity.save
    @entity.default_path.should eq 'this-is-a-test'
  end

  it 'should track created_at and updated_at' do
    @entity.save
    @entity.created_at.should_not be_nil
    @entity.update_attributes(values: { :first => 'value' })
    @entity.updated_at.should_not be_nil
  end

  it 'should convert empty strings to nil' do
    @prop = FactoryGirl.build(:property, kind: :enum, possible: %w(a b c))
    @type = FactoryGirl.create(:type, properties: [@prop])
    puts @type.save
    puts '*' * 80
    puts @type.errors.full_messages
    @entity = FactoryGirl.build(:entity, type: @type,
                                         values: { @prop.name => 'z' })
    @entity.should_not be_valid
    @entity.values[@prop.name] = ''
    @entity.save
    @entity.reload.values[@prop.name].should be_nil
  end

  it 'should track versions'

end
