require 'spec_helper'

describe 'Type' do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)

    3.times do
      @props = [FactoryGirl.build(:property),
                FactoryGirl.build(:property)]
      @type = FactoryGirl.create(:type, properties: @props)
    end
  end

  describe "View list of types" do
    it "shows list of all types" do
      visit admin_types_path 

      for type in Type.all do
        page.should have_link type.name
      end
    end

    it "allows for creating types and redirects to new type" do
      visit admin_types_path

      expect {
        fill_in 'Name', with: 'newTypeFoobar'
        click_on 'Add'
      }.to change(Type, :count).by(1)

      page.should have_content 'newTypeFoobar'
    end
  end

  describe "View specific type" do
    it "shows the correct type name and property names" do
      visit admin_type_path(@type)

      page.should have_content @type.name
      page.should have_content @type.properties[0].name
    end

    it "allows for deleting properties" do
      visit admin_type_path(@type)
      first(:link, 'Remove').click
      @type.reload.properties.should have(1).items
    end

    it "allows for adding properties" do
      visit admin_type_path(@type)
      fill_in 'Name', with: 'newPropertyFoobar'
      select 'String', from: 'Kind'
      click_on 'Add'
      @type.reload.properties.should have(3).items
    end
  end

end
