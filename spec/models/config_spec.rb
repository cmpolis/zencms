require 'spec_helper'

describe ZenConfig do
  before(:each) do
    @config = FactoryGirl.create(:zen_config)
  end

  it 'should have a valid factory' do
    @config.should be_valid
  end

  it 'acts a singleton' do
    FactoryGirl.build(:zen_config).should_not be_valid
    ZenConfig.instance.should eql(@config)
  end

end
