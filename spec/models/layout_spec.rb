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

  it 'can generate HTML with an entity' do
    @props = [FactoryGirl.build(:property, name: 'name'),
              FactoryGirl.build(:property, name: 'color')]
    @layout = FactoryGirl.create(:layout, content:"<h1>{{ mytype.color }}</h1>")
    @type = FactoryGirl.create(:type, properties: @props, 
                                      name: 'mytype',
                                      layout: @layout)
    @entity = FactoryGirl.create(:entity, type: @type, 
                                          values: { name: 'Bob',
                                                    color: 'Red' })        
    @layout.parse_with_entity(@entity).should eq "<h1>Red</h1>"
  end

  it 'can have a parent layout' do
    @parent = FactoryGirl.create(:layout, content:"<p>Parent content</p>{{ child }}")
    @child = FactoryGirl.create(:layout, content:"<h1>Child content</h1>")
    @child.parent = @parent
    @child.save
    @parent.child_layouts.should have(1).items
    @child.parent.should be @parent
  end

  it 'gets rendered inside a parent' do
    @parent = FactoryGirl.create(:layout, content:"<p>Parent content</p>{{ child }}")
    @child = FactoryGirl.create(:layout, content:"<h1>Child content</h1>")
    @child.parent = @parent
    @child.save
    result = @child.parse
    result.should include 'Parent'
    result.should include 'Child'
  end

end
