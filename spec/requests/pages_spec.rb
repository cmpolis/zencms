require 'spec_helper'

describe "Pages" do

  describe "Entity generated page" do
    it "Displays a valid page" do
      @props = [FactoryGirl.build(:property, name: 'name'),
                FactoryGirl.build(:property, name: 'color')]
      @layout = FactoryGirl.create(:fullpage_layout)
      @type = FactoryGirl.create(:type, properties: @props,
                                        name: 'mytype',
                                        layout: @layout,
                                        primary_property: 'name')
      @entity = FactoryGirl.create(:entity, type: @type,
                                            values: { name: 'Bob',
                                                      color: 'Red' })
      visit '/bob'
      page.should have_selector('h1', text: 'Bob')
    end
  end

  describe "Static page" do
    it "Displays a valid static page" do
      @layout = FactoryGirl.create(:static_layout)
      @static = FactoryGirl.create(:static, layout: @layout,
                                            path: 'staticpath')
      visit '/staticpath'
      page.should have_content 'static_content'
    end
  end

end
