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

  it 'should have a lowercase name' do
    @layout = FactoryGirl.create(:layout, name: 'HEadeR')
    @layout.name.should eql 'header'
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
    @child = FactoryGirl.create(:layout, parent: @parent, content:"<h1>Child content</h1>")
    @parent.child_layouts.should have(1).items
    @child.parent.should be @parent
  end

  it 'gets rendered inside a parent' do
    @parent = FactoryGirl.create(:layout, content:"<p>Parent content</p>{{ child }}")
    @child = FactoryGirl.create(:layout, parent: @parent, content:"<h1>Child content</h1>")
    result = @child.parse
    result.should include 'Parent'
    result.should include 'Child'
  end

  it 'can include other layouts' do
    @header = FactoryGirl.create(:layout, name: 'top',
                                          content: '<h1>Header</h1>')
    @footer = FactoryGirl.create(:layout, name: 'bottom',
                                          content: '<h2>Footer</h2>')
    @main = FactoryGirl.create(:layout, name: 'main',
                                        content: '{{ top }}
                                                  <p>Body...</p>>
                                                  {{ bottom }}')
    result = @main.parse
    result.should include 'Header'
    result.should include 'Body'
    result.should include 'Footer'
  end

  it 'should know it\'s entity type' do
    @type = FactoryGirl.create(:type, name: 'Car')
    @entity = FactoryGirl.create(:entity, type: @type)
    @layout = FactoryGirl.create(:layout, content: 'this is a {{ type }}')

    result = @layout.parse_with_entity @entity
    result.should include 'car'
  end

  context 'With config object' do
    before(:each) do
      @config = ZenConfig.instance
      @config.update_attributes(ga_enabled: true,
                                ga_tracking_id: 'TESTGAID',
                                base_url: 'http://localhost:3000',
                                admin_email: 'test@test.com',
                                twitter_handle: 'chrispolis')

    end

    it 'renders ga code' do
      @layout = FactoryGirl.create(:layout, content: '{{ ga_code }}')
      @layout.parse.should include 'TESTGAID'
    end

    it 'renders twitter handle url' do
      @layout = FactoryGirl.create(:layout, content: '{{ twitter_url }}')
      @layout.parse.should include 'twitter.com/chrispolis'
    end

    it 'renders base url' do
      @layout = FactoryGirl.create(:layout, content: '{{ base_url }}')
      @layout.parse.should include 'localhost:3000'
    end

    it 'renders admin email' do
      @layout = FactoryGirl.create(:layout, content: '{{ admin_email }}')
      @layout.parse.should include 'test@test.com'
    end
  end

end
