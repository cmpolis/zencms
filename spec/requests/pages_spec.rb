require 'spec_helper'

describe "Pages" do

  describe "Entity generated page" do
    before(:each) do
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
    end

    it "Displays a valid page" do
      visit '/bob'
      page.should have_selector('h1', text: 'Bob')
    end

    it "Includes linked stylesheets" do
      @layout.styles << FactoryGirl.create(:style, content: '.test-selector { color: red; }')
      @layout.save

      visit '/bob'
      page.body.should include "href='/css/#{@layout.styles.first}.css"
    end

    it "Includes linked javascripts", js: true do
      @layout.scripts << FactoryGirl.create(:script, content: 'alert(\'foo\');')
      @layout.save

      visit '/bob'
      page.driver.alert_messages.should include 'foo'
    end

    it "Includes referenced javascripts", js: true do
      @layout.scripts = [ FactoryGirl.create(:jquery) ]
      @layout.save

      visit '/bob'
      page.should have_xpath("//script[contains(@src, 'jquery')]")
    end

    it "Includes referenced stylesheets" do
      @layout.styles = [ FactoryGirl.create(:referenced_css) ]
      @layout.save

      visit '/bob'
      page.should have_xpath("//link[contains(@href, '.css')]")
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
