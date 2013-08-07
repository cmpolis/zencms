require 'spec_helper'

describe 'Dashboard' do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)
  end

  describe "View dashboard" do
    it "Links to other sections" do
      visit admin_dashboard_path 

      page.should have_content /dashboard/i
      page.should have_link 'Types'
      page.should have_link 'Collections'
      page.should have_link 'Layouts'
      page.should have_link 'Styles'
      page.should have_link 'Users'
      page.should have_link 'Config'
    end

    it "Links to each type" do
      @props = [FactoryGirl.build(:property),
                FactoryGirl.build(:property)]
      @type = FactoryGirl.create(:type, properties: @props)
      visit admin_dashboard_path
      page.should have_link @type.name

      click_link @type.name
      page.should have_content @type.name
    end
  end

end
