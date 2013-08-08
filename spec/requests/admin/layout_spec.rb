require 'spec_helper'

describe 'Layout' do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)

    @props = [FactoryGirl.build(:property),
              FactoryGirl.build(:property)]
    @type = FactoryGirl.create(:type, properties: @props)
    3.times do
      @layout = FactoryGirl.create(:layout)
    end
    @type.layout = @layout
    @type.save
  end

  describe "View list of layouts" do
    before { visit admin_layouts_path }

    it "shows list of all layouts" do
      for layout in Layout.all do
        page.should have_link layout.name
      end
    end

    it "allows for creating new layouts and redirects to new layout" do
      expect {
        fill_in 'Name', with: 'New Layout'
        fill_in 'Content', with: '<p>My layout: {{ object.name }}</p>'
        click_on 'Add'
      }.to change(Layout, :count).by(1)
      page.should have_content 'New Layout'
    end
  end

  describe "View specific layout" do
    before { visit admin_layout_path(@layout) }

    it "shows the correct layout name" do
      page.should have_content @layout.name
    end

    it "allows for editing content" do
      content = '<p>This is new content...</p>'
      fill_in 'Content', with: content
      click_on 'Update'
      @layout.reload.content.should eq content
    end
  end

end
