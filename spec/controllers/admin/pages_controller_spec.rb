require 'spec_helper'

describe PagesController do
  before(:each) do
    @layout = FactoryGirl.create(:fullpage_layout)
    @properties = [FactoryGirl.build(:property, name: 'name'),
                      FactoryGirl.build(:property, name: 'color')]
    @type = FactoryGirl.create(:type, name: 'mytype',
                                      properties: @properties,
                                      layout: @layout)
    @entity = FactoryGirl.create(:entity, type: @type,
                                          default_path: 'testpath',
                                          values: { name: 'test' })

  end

  describe "Load page by default path" do
    it "loads the correct entity" do
      get :show, path: 'testpath'

      assigns(:entity).should eq(@entity)
      response.body.should include 'test'
    end

    it "can load as root if default path is ''" do
      @entity.update_attributes(default_path: '')
      get :show, path: ''

      assigns(:entity).should eq(@entity)
      response.body.should include 'test'
    end

    it "shows the welcome page if there is no page with default route" do
      get :show, path: ''
      response.should render_template :welcome
    end
  
  end

end
