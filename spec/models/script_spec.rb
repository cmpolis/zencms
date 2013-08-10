require 'spec_helper'

describe Script do
  before(:each) do
    @script = FactoryGirl.create(:script)
  end

  it 'should have a valid factory' do
    @script.should be_valid
  end

  it 'must have a unique name' do
    FactoryGirl.build(:script, name: nil).should_not be_valid
    FactoryGirl.build(:script, name: @script.name).should_not be_valid
  end

  it 'can belong to and have many layouts' do
    @layout = FactoryGirl.create(:layout, scripts: [@script])
    @layout.scripts.should include @script
    @script.layouts.should include @layout
  end

end
