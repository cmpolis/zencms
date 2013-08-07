require 'spec_helper'

describe User do

  it 'should have a valid factory' do
    FactoryGirl.create(:user).should be_valid
  end

  it 'should set the first user as an admin' do
    DatabaseCleaner.clean
    @first = FactoryGirl.create(:user)
    @second = FactoryGirl.create(:user, email: 'anotheremail@test.com')

    @first.is_admin?.should be_true
    @second.is_admin?.should_not be_true
  end

end
