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

  it 'renders ga code' do
    @config.update_attributes(ga_tracking_id: 'TESTID',
                              ga_enabled: true)
    @config.ga_code.should include 'TESTID'
    @config.update_attributes(ga_enabled: false)
    @config.ga_code.should be_blank 
  end

end
