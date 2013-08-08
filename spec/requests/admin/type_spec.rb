require 'spec_helper'

describe 'Type' do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)

    @layouts = []
    3.times do
      @layouts << FactoryGirl.create(:layout)
      @props = [FactoryGirl.build(:property),
                FactoryGirl.build(:property)]
      @type = FactoryGirl.create(:type, properties: @props)
    end
  end

  describe "View list of types" do
    before { visit admin_types_path }

    it "shows list of all types" do
      for type in Type.all do
        page.should have_link type.name
      end
    end

    it "allows for creating types and redirects to new type" do
      expect {
        fill_in 'Name', with: 'newTypeFoobar'
        click_on 'Add'
      }.to change(Type, :count).by(1)
      page.should have_content 'newTypeFoobar'
    end
  end

  describe "View specific type" do
    before { visit admin_type_path(@type) }

    it "shows the correct type name and property names" do
      page.should have_content @type.name
      page.should have_content @type.properties[0].name
    end

    it "allows for deleting properties" do
      first(:link, 'Remove').click
      @type.reload.properties.should have(1).items
    end

    it "allows for adding properties" do
      fill_in 'Name', with: 'newPropertyFoobar'
      select 'String', from: 'Kind'
      click_on 'Add'
      @type.reload.properties.should have(3).items
    end

    it "allows for changing the default layout" do
      page.should have_select 'Layout'
      select @layouts.first.name, from: 'Layout'
      click_on 'Update'
      @type.reload.layout.name.should eq @layouts.first.name
    end

    it "allows for setting the primary property" do
      page.should have_select 'Primary Property'
      select @props[1].name, from: 'Primary Property'
      click_on 'Update'
      @type.reload.primary_property.should eq @props[1].name
    end
  end

end
