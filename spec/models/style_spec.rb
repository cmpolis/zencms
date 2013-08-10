require 'spec_helper'

describe Style do
  before(:each) do
    @style = FactoryGirl.create(:style)
  end

  it 'should have a valid factory' do
    @style.should be_valid
  end

  it 'must have a unique name' do
    FactoryGirl.build(:style, name: nil).should_not be_valid
    FactoryGirl.build(:style, name: @style.name).should_not be_valid
  end

  it 'can belong to and have many layouts' do
    @layout = FactoryGirl.create(:layout, styles: [@style])
    @layout.styles.should include @style
    @style.layouts.should include @layout
  end

end
