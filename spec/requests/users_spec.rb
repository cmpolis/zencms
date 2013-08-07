require 'spec_helper'

describe "Users" do

  describe "User registration" do
    it "Creates a new user" do
      visit '/register'
      expect {
        fill_in 'Email', with: "test@test123457.com"
        fill_in 'Username', with: "testusername"
        fill_in 'Password', with: "foobar123"
        click_on 'Register'
      }.to change(User,:count).by(1)
    end
  end

  describe "User login" do
    it "Logs in a valid user" do
      @user = FactoryGirl.create(:user)
      visit '/login'
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'foobar123'
      click_on 'Login'
      expect(page).to have_link 'Logout'
    end

    it "Links to registration and password form" do
      visit '/login' do
        expect(page).to have_link 'Register'
        expect(page).to have_link /forgot.*password/i
      end
    end
  end


end
